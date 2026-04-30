import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_course_service.dart';
import '../services/firestore_user_service.dart';
import '../models/course_model.dart';
import '../core/asset_path.dart';

/// Controller responsible for managing course data and user progress
/// Updated to use a flat Firestore structure and lazy loading.
class CourseController extends GetxController {
  // Observables
  var enrolledCourses = <Course>[].obs;
  var availableCourses = <Course>[].obs;
  var isCoursesLoading = false.obs;
  
  // Lazy loaded data maps: Key is the parent ID
  var courseModules = <String, List<Module>>{}.obs;
  var moduleTopics = <String, List<Topic>>{}.obs;
  var parentQuizzes = <String, List<QuizQuestion>>{}.obs;
  
  var achievements = <Achievement>[].obs;

  final FirestoreCourseService _firestoreService = FirestoreCourseService();
  final FirestoreUserService _userService = FirestoreUserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    print('CourseController initialized (Flat)');
    _checkAndLoadUserData();
  }

  Future<void> _checkAndLoadUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        if (availableCourses.isEmpty) {
          await loadCoursesFromFirestore();
        }
        await loadUserData();
      }
    } catch (e) {
      print('Error checking user login status: $e');
    }
  }

  void clearUserData() {
    enrolledCourses.clear();
    achievements.clear();
  }

  /// Loads ONLY the courses metadata (Flat)
  Future<void> loadCoursesFromFirestore() async {
    try {
      isCoursesLoading.value = true;
      print('Loading courses metadata from Firestore...');
      final coursesSnapshot = await _firestoreService.getAllCourses().first;
      
      final courses = coursesSnapshot.docs.map((doc) {
        return Course.fromFirestore(doc);
      }).toList();

      availableCourses.assignAll(courses);
      print('Loaded ${availableCourses.length} courses metadata');
    } catch (e) {
      print('Error loading courses: $e');
    } finally {
      isCoursesLoading.value = false;
    }
  }

  /// Lazy load modules for a specific course
  Future<List<Module>> getModulesForCourse(String courseId) async {
    if (courseModules.containsKey(courseId)) {
      return courseModules[courseId]!;
    }
    
    try {
      print('Lazy loading modules for course: $courseId');
      final snapshot = await _firestoreService.getCourseModules(courseId).first;
      final modules = snapshot.docs.map((doc) => Module.fromFirestore(doc)).toList();
      courseModules[courseId] = modules;
      return modules;
    } catch (e) {
      print('Error loading modules: $e');
      return [];
    }
  }

  /// Lazy load topics for a specific module
  Future<List<Topic>> getTopicsForModule(String moduleId) async {
    if (moduleTopics.containsKey(moduleId)) {
      return moduleTopics[moduleId]!;
    }
    
    try {
      print('Lazy loading topics for module: $moduleId');
      final snapshot = await _firestoreService.getModuleTopics(moduleId).first;
      final topics = snapshot.docs.map((doc) => Topic.fromFirestore(doc)).toList();
      moduleTopics[moduleId] = topics;
      return topics;
    } catch (e) {
      print('Error loading topics: $e');
      return [];
    }
  }

  /// Lazy load quiz questions for a module or topic
  Future<List<QuizQuestion>> getQuizzes(String parentId) async {
    if (parentQuizzes.containsKey(parentId)) {
      return parentQuizzes[parentId]!;
    }
    
    try {
      print('Lazy loading quizzes for parent: $parentId');
      final snapshot = await _firestoreService.getQuizQuestions(parentId).first;
      final quizzes = snapshot.docs.map((doc) => QuizQuestion.fromFirestore(doc)).toList();
      parentQuizzes[parentId] = quizzes;
      return quizzes;
    } catch (e) {
      print('Error loading quizzes: $e');
      return [];
    }
  }

  // --- Enrollment & Achievements ---

  Future<void> enrollCourse(Course course) async {
    if (!isCourseEnrolled(course.name)) {
      enrolledCourses.add(course);
      final user = _auth.currentUser;
      if (user != null) {
        await _userService.enrollUserInCourse(user.uid, course.name);
      }
    }
  }

  bool isCourseEnrolled(String courseName) {
    return enrolledCourses.any((course) => course.name == courseName);
  }

  Course? getCourseByName(String name) {
    return availableCourses.firstWhereOrNull((c) => c.name == name);
  }

  // Simplified progress helpers for UI compatibility
  double getOverallProgressBySubtopics() {
    if (enrolledCourses.isEmpty) return 0.0;
    // Real calculation would require all data to be loaded
    return 0.0; 
  }

  int getTotalSubtopicsForCourse(String courseName) {
    return 0; // Placeholder
  }

  int getCompletedSubtopicsForCourse(String courseName) {
    return achievements.where((a) => a.courseName == courseName).length;
  }

  Future<void> removeCourse(String courseName) async {
    enrolledCourses.removeWhere((course) => course.name == courseName);
    final user = _auth.currentUser;
    if (user != null) {
      await _userService.removeUserFromCourse(user.uid, courseName);
      await _userService.removeUserAchievementsForCourse(user.uid, courseName);
      achievements.removeWhere((a) => a.courseName == courseName);
    }
  }

  Future<void> loadUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final enrolledNames = await _userService.getUserEnrolledCourses(user.uid);
      List<Course> newlyEnrolled = [];
      for (var name in enrolledNames) {
        final course = availableCourses.firstWhereOrNull((c) => c.name == name);
        if (course != null) newlyEnrolled.add(course);
      }
      
      // Use assignAll for an atomic update to prevent "blink" issues
      enrolledCourses.assignAll(newlyEnrolled);

      final userAchievements = await _userService.getUserAchievements(user.uid);
      achievements.assignAll(userAchievements);
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> addAchievement(Achievement achievement) async {
    achievements.add(achievement);
    final user = _auth.currentUser;
    if (user != null) {
      await _userService.addUserAchievement(user.uid, achievement);
    }
  }

  // Helper for icons (keep existing logic)
  String getCourseIcon(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'flutter': return AssetsPath.flutterIconSvg;
      case 'c': return AssetsPath.cIconSvg;
      case 'c++': return AssetsPath.cppIconSvg;
      case 'java': return AssetsPath.javaIconSvg;
      case 'database': return AssetsPath.databaseIconSvg;
      case 'mysql': return AssetsPath.mysqlIconSvg;
      case 'html': return AssetsPath.htmlIconSvg;
      case 'python': return AssetsPath.pythonIconSvg;
      case 'dart': return AssetsPath.dartIconSvg;
      case 'react': return AssetsPath.reactIconSvg;
      default: return AssetsPath.flutterIconSvg;
    }
  }
}
