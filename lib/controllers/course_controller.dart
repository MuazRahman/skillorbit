import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_course_service.dart';
import '../services/firestore_user_service.dart';
import '../models/course_model.dart';
import '../core/asset_path.dart';

/// Controller responsible for managing course data and user progress.
///
/// Uses real-time Firestore listeners for courses so that admin changes
/// are automatically reflected in the user UI without needing to restart
/// or clear app data.
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

  /// Subscription to the real-time courses stream from Firestore.
  StreamSubscription? _coursesSubscription;

  @override
  void onInit() {
    super.onInit();
    print('CourseController initialized (Flat + Real-time)');
    _startListeningToCourses();
    _checkAndLoadUserData();
  }

  @override
  void onClose() {
    _coursesSubscription?.cancel();
    super.onClose();
  }

  /// Start listening to the courses collection in real-time.
  /// Any time a course is added, updated, or deleted in Firestore
  /// (e.g. from the admin panel), this will automatically update
  /// the availableCourses list and the UI.
  void _startListeningToCourses() {
    isCoursesLoading.value = true;
    _coursesSubscription?.cancel();
    _coursesSubscription = _firestoreService.getAllCourses().listen(
      (snapshot) {
        final courses = snapshot.docs.map((doc) {
          return Course.fromFirestore(doc);
        }).toList();

        availableCourses.assignAll(courses);
        print('Real-time update: ${availableCourses.length} courses');
        isCoursesLoading.value = false;

        // Also refresh enrolled courses to pick up any name/description changes
        _refreshEnrolledFromAvailable();
      },
      onError: (e) {
        print('Error in courses stream: $e');
        isCoursesLoading.value = false;
      },
    );
  }

  /// Re-maps enrolled courses from the latest availableCourses data
  /// so that if a course name/description/icon was updated by admin,
  /// the enrolled list also reflects those changes.
  void _refreshEnrolledFromAvailable() {
    if (enrolledCourses.isEmpty) return;

    final enrolledNames = enrolledCourses.map((c) => c.name).toList();
    final updatedEnrolled = <Course>[];
    for (var name in enrolledNames) {
      final course = availableCourses.firstWhereOrNull((c) => c.name == name);
      if (course != null) updatedEnrolled.add(course);
    }
    enrolledCourses.assignAll(updatedEnrolled);
  }

  Future<void> _checkAndLoadUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
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

  /// Clears all cached data and reloads everything from Firestore.
  /// Call this on pull-to-refresh to pick up admin changes
  /// for modules, topics, and quizzes (courses are already real-time).
  Future<void> refreshAllData() async {
    // Clear all in-memory caches for sub-level data
    courseModules.clear();
    moduleTopics.clear();
    parentQuizzes.clear();

    // Courses are already real-time via stream listener,
    // but force a fresh snapshot just in case
    await _firestoreService.getAllCourses().first;

    // Reload user-specific data
    await loadUserData();
  }

  /// Loads ONLY the courses metadata (one-shot, for manual refresh).
  /// Normally not needed since the real-time listener handles this.
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

  /// Lazy load modules for a specific course.
  /// Set [forceRefresh] to true to bypass cache and re-fetch from Firestore server.
  Future<List<Module>> getModulesForCourse(String courseId, {bool forceRefresh = false}) async {
    if (!forceRefresh && courseModules.containsKey(courseId)) {
      return courseModules[courseId]!;
    }

    try {
      print('Loading modules for course: $courseId (forceRefresh: $forceRefresh)');
      // Use direct server fetch to bypass Firestore local cache
      final snapshot = await _firestoreService.getCourseModulesDirect(courseId);
      final modules =
          snapshot.docs.map((doc) => Module.fromFirestore(doc)).toList();
      courseModules[courseId] = modules;
      return modules;
    } catch (e) {
      print('Error loading modules: $e');
      // Fallback: try from cache if server is unreachable
      try {
        final snapshot = await _firestoreService.getCourseModules(courseId).first;
        final modules =
            snapshot.docs.map((doc) => Module.fromFirestore(doc)).toList();
        courseModules[courseId] = modules;
        return modules;
      } catch (_) {
        return courseModules[courseId] ?? [];
      }
    }
  }

  /// Lazy load topics for a specific module.
  /// Set [forceRefresh] to true to bypass cache and re-fetch from Firestore server.
  Future<List<Topic>> getTopicsForModule(String moduleId, {bool forceRefresh = false}) async {
    if (!forceRefresh && moduleTopics.containsKey(moduleId)) {
      return moduleTopics[moduleId]!;
    }

    try {
      print('Loading topics for module: $moduleId (forceRefresh: $forceRefresh)');
      // Use direct server fetch to bypass Firestore local cache
      final snapshot = await _firestoreService.getModuleTopicsDirect(moduleId);
      final topics =
          snapshot.docs.map((doc) => Topic.fromFirestore(doc)).toList();
      moduleTopics[moduleId] = topics;
      return topics;
    } catch (e) {
      print('Error loading topics: $e');
      // Fallback: try from cache if server is unreachable
      try {
        final snapshot = await _firestoreService.getModuleTopics(moduleId).first;
        final topics =
            snapshot.docs.map((doc) => Topic.fromFirestore(doc)).toList();
        moduleTopics[moduleId] = topics;
        return topics;
      } catch (_) {
        return moduleTopics[moduleId] ?? [];
      }
    }
  }

  /// Lazy load quiz questions for a module or topic.
  /// Set [forceRefresh] to true to bypass cache and re-fetch from Firestore server.
  Future<List<QuizQuestion>> getQuizzes(String parentId, {bool forceRefresh = false}) async {
    if (!forceRefresh && parentQuizzes.containsKey(parentId)) {
      return parentQuizzes[parentId]!;
    }

    try {
      print('Loading quizzes for parent: $parentId (forceRefresh: $forceRefresh)');
      // Use direct server fetch to bypass Firestore local cache
      final snapshot = await _firestoreService.getQuizQuestionsDirect(parentId);
      final quizzes =
          snapshot.docs.map((doc) => QuizQuestion.fromFirestore(doc)).toList();
      parentQuizzes[parentId] = quizzes;
      return quizzes;
    } catch (e) {
      print('Error loading quizzes: $e');
      // Fallback: try from cache if server is unreachable
      try {
        final snapshot = await _firestoreService.getQuizQuestions(parentId).first;
        final quizzes =
            snapshot.docs.map((doc) => QuizQuestion.fromFirestore(doc)).toList();
        parentQuizzes[parentId] = quizzes;
        return quizzes;
      } catch (_) {
        return parentQuizzes[parentId] ?? [];
      }
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
      case 'flutter':
        return AssetsPath.flutterIconSvg;
      case 'c':
        return AssetsPath.cIconSvg;
      case 'c++':
        return AssetsPath.cppIconSvg;
      case 'java':
        return AssetsPath.javaIconSvg;
      case 'database':
        return AssetsPath.databaseIconSvg;
      case 'mysql':
        return AssetsPath.mysqlIconSvg;
      case 'html':
        return AssetsPath.htmlIconSvg;
      case 'python':
        return AssetsPath.pythonIconSvg;
      case 'dart':
        return AssetsPath.dartIconSvg;
      case 'react':
        return AssetsPath.reactIconSvg;
      default:
        return AssetsPath.flutterIconSvg;
    }
  }
}
