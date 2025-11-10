import 'package:get/get.dart';
import 'package:skillorbit/core/asset_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_course_service.dart';
import '../services/firestore_user_service.dart';
import '../models/course_model.dart';

/// Controller responsible for managing course data and user progress
///
/// This controller handles fetching course data from Firestore, tracking
/// user enrollments, and managing achievements. It follows the MVC pattern
/// by separating business logic from UI concerns.
class CourseController extends GetxController {
  /// List of courses the user has enrolled in
  /// This is an observable list that automatically updates UI when changed
  var enrolledCourses = <Course>[].obs;

  /// List of all available courses in the system
  /// This list contains all courses from Firestore, regardless of enrollment status
  var availableCourses = <Course>[].obs;

  /// Loading state for courses
  var isCoursesLoading = false.obs;

  /// List of user achievements
  /// Tracks completed topics and subtopics
  var achievements = <Achievement>[].obs;

  /// Service for interacting with Firestore database
  final FirestoreCourseService _firestoreService = FirestoreCourseService();
  final FirestoreUserService _userService = FirestoreUserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Initializes the controller
  ///
  /// This method is automatically called when the controller is created.
  /// We don't load courses here anymore as it's handled by the splash screen.
  /// However, we check if a user is already logged in and load their data.
  @override
  void onInit() {
    super.onInit();
    print('CourseController initialized');
    // Course loading is now handled by the splash screen

    // Check if user is already logged in and load their data
    _checkAndLoadUserData();
  }

  /// Check if user is logged in and load their data
  ///
  /// This method is called during initialization to check if a user is already
  /// logged in (e.g., after hot restart) and load their enrolled courses and achievements.
  Future<void> _checkAndLoadUserData() async {
    try {
      // Check if user is logged in
      final user = _auth.currentUser;
      if (user != null) {
        print('User is already logged in (${user.uid}), loading user data');
        // Load user data in background
        // Add a small delay to ensure controllers are fully initialized
        await Future.delayed(const Duration(milliseconds: 100));

        // Ensure available courses are loaded before loading user data
        if (availableCourses.isEmpty) {
          print('Available courses not loaded yet, loading them first');
          await loadCoursesFromFirestore();
        }

        await loadUserData();
        print('User data loading completed for user: ${user.uid}');
      } else {
        print('No user logged in');
      }
    } catch (e) {
      print('Error checking user login status: $e');
    }
  }

  /// Clears all user-specific data
  ///
  /// This method should be called when a user logs out to clear their
  /// enrolled courses and achievements from memory.
  void clearUserData() {
    print('Clearing user data');
    enrolledCourses.clear();
    achievements.clear();
    print('User data cleared');
  }

  /// Loads all courses from Firestore database
  ///
  /// Fetches course data from Firestore and builds the complete course structure
  /// including topics, subtopics, and quiz questions. This method handles both
  /// detailed courses (with full structure) and simple courses (with topic names only).
  /// Courses are stored in availableCourses list, not enrolledCourses.
  Future<void> loadCoursesFromFirestore() async {
    try {
      isCoursesLoading.value = true;
      print('Loading courses from Firestore...');
      final coursesSnapshot = await _firestoreService.getAllCourses().first;
      print('Received ${coursesSnapshot.docs.length} courses from Firestore');
      final courses = <Course>[];

      for (var doc in coursesSnapshot.docs) {
        try {
          print('Processing course document ID: ${doc.id}');
          final data = doc.data() as Map<String, dynamic>;
          print('Course data: $data');

          final courseModel = Course.fromFirestore(doc);
          print(
            'Course model name: ${courseModel.name}, hasDetailedTopics: ${courseModel.hasDetailedTopics}',
          );

          // For courses with detailed topics, fetch the full structure
          if (courseModel.hasDetailedTopics) {
            print('Loading detailed topics for course: ${courseModel.name}');
            final topics = await loadTopicsForCourse(doc.id);
            print(
              'Loaded ${topics.length} topics for course: ${courseModel.name}',
            );
            final iconPath = getCourseIcon(courseModel.name);
            print('Setting icon for course ${courseModel.name}: $iconPath');
            courses.add(
              Course(
                id: courseModel.id,
                name: courseModel.name,
                description: courseModel.description,
                topics: topics,
                icon: iconPath,
                hasDetailedTopics: courseModel.hasDetailedTopics,
                topicNames: courseModel.topicNames,
              ),
            );
            print(
              'Added course ${courseModel.name} to courses list. Current count: ${courses.length}',
            );
          } else {
            // For courses with simple topic lists, load the topic names from Firestore
            print('Course ${courseModel.name} has simple topics');
            final topicNames = await _firestoreService.getSimpleCourseTopics(
              doc.id,
            );
            print(
              'Loaded ${topicNames.length} topic names for course: ${courseModel.name}',
            );
            print('Topic names: $topicNames');
            final iconPath = getCourseIcon(courseModel.name);
            print('Setting icon for course ${courseModel.name}: $iconPath');
            courses.add(
              Course(
                id: courseModel.id,
                name: courseModel.name,
                description: courseModel.description,
                topics: [], // Will be populated when needed
                icon: iconPath,
                hasDetailedTopics: courseModel.hasDetailedTopics,
                topicNames: topicNames,
              ),
            );
            print(
              'Added course ${courseModel.name} to courses list. Current count: ${courses.length}',
            );
          }
        } catch (courseError) {
          print('Error processing course document ${doc.id}: $courseError');
          print('Stack trace: ${StackTrace.current}');
        }
      }

      // Store all courses in availableCourses, keep enrolledCourses empty initially
      print('Assigning ${courses.length} courses to availableCourses');
      availableCourses.assignAll(courses);
      print('Available courses updated. Count: ${availableCourses.length}');
      // enrolledCourses remains empty until user explicitly enrolls
    } catch (e) {
      print('Error loading courses from Firestore: $e');
      // Print stack trace for better debugging
      print('Stack trace: ${StackTrace.current}');
    } finally {
      isCoursesLoading.value = false;
    }
  }

  /// Gets the appropriate icon for a course
  ///
  /// Returns a file path or identifier for the course icon based on the course name.
  /// If no specific icon is found, returns a default icon.
  ///
  /// [courseName] - Name of the course to get an icon for
  String getCourseIcon(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'flutter':
        // Return SVG icon
        return AssetsPath.flutterIconSvg;
      // return 'assets/images/flutter-svg.svg';
      case 'c':
        return AssetsPath.cIconSvg;
      // return 'assets/images/c_svg.svg';
      case 'c++':
        return AssetsPath.cppIconSvg;
      // return 'assets/images/c++_svg.svg';
      case 'java':
        return AssetsPath.javaIconSvg;
      // return 'assets/images/java_svg.svg';
      case 'database':
        return AssetsPath.databaseIconSvg;
      // return 'assets/images/database_svg.svg';
      case 'mysql':
        return AssetsPath.mysqlIconSvg;
      // return 'assets/images/mysql_svg.svg';
      case 'html':
        return AssetsPath.htmlIconSvg;
      // return 'assets/images/html_svg.svg';
      case 'python':
        return AssetsPath.pythonIconSvg;
      // return 'assets/images/python_svg.svg';
      case 'dart':
        return AssetsPath.dartIconSvg;
      // return 'assets/images/dart_svg.svg';
      case 'react':
        return AssetsPath.reactIconSvg;
      // return 'assets/images/react-svg.svg';
      default:
        return AssetsPath.flutterIconSvg; // Use flutter icon as default
      // return 'assets/images/flutter-svg.svg';
    }
  }

  /// Loads all topics for a specific course
  ///
  /// Fetches topics from Firestore for the given course ID and builds
  /// the complete topic structure including subtopics and quiz questions.
  ///
  /// [courseId] - ID of the course to load topics for
  Future<List<Topic>> loadTopicsForCourse(String courseId) async {
    try {
      print('Loading topics for course ID: $courseId');
      final topicsSnapshot =
          await _firestoreService.getCourseTopics(courseId).first;
      print(
        'Received ${topicsSnapshot.docs.length} topics for course ID: $courseId',
      );
      final topics = <Topic>[];

      for (var doc in topicsSnapshot.docs) {
        print('Processing topic: ${doc.id}');
        final topicModel = Topic.fromFirestore(doc);

        // Load quiz questions for this topic
        print('Loading quiz questions for topic: ${topicModel.name}');
        final quizQuestions = await loadQuizQuestionsForTopic(courseId, doc.id);
        print(
          'Loaded ${quizQuestions.length} quiz questions for topic: ${topicModel.name}',
        );

        // Load subtopics for this topic
        print('Loading subtopics for topic: ${topicModel.name}');
        final subtopics = await loadSubtopicsForTopic(courseId, doc.id);
        print(
          'Loaded ${subtopics.length} subtopics for topic: ${topicModel.name}',
        );

        topics.add(
          Topic(
            id: topicModel.id,
            name: topicModel.name,
            description: topicModel.description,
            tutorialLink: topicModel.tutorialLink,
            order: topicModel.order,
            quizQuestions: quizQuestions,
            subtopics: subtopics,
            isCompleted: false,
          ),
        );
      }

      // Sort topics by order
      topics.sort((a, b) => a.order.compareTo(b.order));
      return topics;
    } catch (e) {
      print('Error loading topics for course $courseId: $e');
      // Print stack trace for better debugging
      print('Stack trace: ${StackTrace.current}');
      return [];
    }
  }

  /// Loads all subtopics for a specific topic
  ///
  /// Fetches subtopics from Firestore for the given course and topic IDs.
  ///
  /// [courseId] - ID of the course containing the topic
  /// [topicId] - ID of the topic to load subtopics for
  Future<List<Subtopic>> loadSubtopicsForTopic(
    String courseId,
    String topicId,
  ) async {
    try {
      print('Loading subtopics for course ID: $courseId, topic ID: $topicId');
      final subtopicsSnapshot =
          await _firestoreService.getSubtopics(courseId, topicId).first;
      print(
        'Received ${subtopicsSnapshot.docs.length} subtopics for course ID: $courseId, topic ID: $topicId',
      );
      final subtopics = <Subtopic>[];

      for (var doc in subtopicsSnapshot.docs) {
        print('Processing subtopic: ${doc.id}');
        final subtopicModel = Subtopic.fromFirestore(doc);

        // Load quiz questions for this subtopic
        print('Loading quiz questions for subtopic: ${subtopicModel.name}');
        final quizQuestions = await loadQuizQuestionsForSubtopic(
          courseId,
          topicId,
          doc.id,
        );
        print(
          'Loaded ${quizQuestions.length} quiz questions for subtopic: ${subtopicModel.name}',
        );

        subtopics.add(
          Subtopic(
            id: subtopicModel.id,
            name: subtopicModel.name,
            description: subtopicModel.description,
            tutorialLink: subtopicModel.tutorialLink,
            videoUrl: subtopicModel.videoUrl,
            order: subtopicModel.order,
            quizQuestions: quizQuestions,
          ),
        );
      }

      // Sort subtopics by order
      subtopics.sort((a, b) => a.order.compareTo(b.order));
      return subtopics;
    } catch (e) {
      print('Error loading subtopics for topic $topicId: $e');
      // Print stack trace for better debugging
      print('Stack trace: ${StackTrace.current}');
      return [];
    }
  }

  /// Loads quiz questions for a specific topic
  ///
  /// Fetches quiz questions from Firestore for the given course and topic IDs.
  ///
  /// [courseId] - ID of the course containing the topic
  /// [topicId] - ID of the topic to load quiz questions for
  Future<List<QuizQuestion>> loadQuizQuestionsForTopic(
    String courseId,
    String topicId,
  ) async {
    try {
      print(
        'Loading quiz questions for course ID: $courseId, topic ID: $topicId',
      );
      final questionsSnapshot = await _firestoreService
          .getTopicQuizQuestions(courseId, topicId)
          .first;
      print(
        'Received ${questionsSnapshot.docs.length} quiz questions for course ID: $courseId, topic ID: $topicId',
      );
      final questions = <QuizQuestion>[];

      for (var doc in questionsSnapshot.docs) {
        print('Processing quiz question: ${doc.id}');
        final questionModel = QuizQuestion.fromFirestore(doc);
        questions.add(
          QuizQuestion(
            id: questionModel.id,
            question: questionModel.question,
            options: questionModel.options,
            correctAnswerIndex: questionModel.correctAnswerIndex,
            order: questionModel.order,
          ),
        );
      }

      // Sort questions by order
      questions.sort((a, b) => a.order.compareTo(b.order));
      return questions;
    } catch (e) {
      print('Error loading quiz questions for topic $topicId: $e');
      // Print stack trace for better debugging
      print('Stack trace: ${StackTrace.current}');
      return [];
    }
  }

  /// Loads quiz questions for a specific subtopic
  ///
  /// Fetches quiz questions from Firestore for the given course, topic, and subtopic IDs.
  ///
  /// [courseId] - ID of the course containing the subtopic
  /// [topicId] - ID of the topic containing the subtopic
  /// [subtopicId] - ID of the subtopic to load quiz questions for
  Future<List<QuizQuestion>> loadQuizQuestionsForSubtopic(
    String courseId,
    String topicId,
    String subtopicId,
  ) async {
    try {
      print(
        'Loading quiz questions for course ID: $courseId, topic ID: $topicId, subtopic ID: $subtopicId',
      );
      final questionsSnapshot = await _firestoreService
          .getSubtopicQuizQuestions(courseId, topicId, subtopicId)
          .first;
      print(
        'Received ${questionsSnapshot.docs.length} quiz questions for course ID: $courseId, topic ID: $topicId, subtopic ID: $subtopicId',
      );
      final questions = <QuizQuestion>[];

      for (var doc in questionsSnapshot.docs) {
        print('Processing quiz question: ${doc.id}');
        final questionModel = QuizQuestion.fromFirestore(doc);
        questions.add(
          QuizQuestion(
            id: questionModel.id,
            question: questionModel.question,
            options: questionModel.options,
            correctAnswerIndex: questionModel.correctAnswerIndex,
            order: questionModel.order,
          ),
        );
      }

      // Sort questions by order
      questions.sort((a, b) => a.order.compareTo(b.order));
      return questions;
    } catch (e) {
      print('Error loading quiz questions for subtopic $subtopicId: $e');
      // Print stack trace for better debugging
      print('Stack trace: ${StackTrace.current}');
      return [];
    }
  }

  /// Enrolls a user in a course
  ///
  /// Adds a course to the user's enrolled courses list if not already enrolled.
  /// Also updates the user's document in Firestore to reflect the enrollment.
  ///
  /// [course] - The course to enroll in
  Future<void> enrollCourse(Course course) async {
    // Check if course is already enrolled
    if (!isCourseEnrolled(course.name)) {
      enrolledCourses.add(course);

      // Update Firestore with the enrollment
      final user = _auth.currentUser;
      if (user != null) {
        try {
          await _userService.enrollUserInCourse(user.uid, course.name);
          print(
              'Successfully enrolled user ${user.uid} in course ${course.name}');
        } catch (e) {
          print(
              'Error enrolling user ${user.uid} in course ${course.name}: $e');
          // Remove from local list if Firestore update failed
          enrolledCourses.remove(course);
          rethrow;
        }
      }
    }
  }

  /// Checks if a user is enrolled in a course
  ///
  /// Returns true if the user is already enrolled in the specified course.
  ///
  /// [courseName] - Name of the course to check
  bool isCourseEnrolled(String courseName) {
    return enrolledCourses.any((course) => course.name == courseName);
  }

  /// Removes a course from the user's enrolled courses
  ///
  /// Removes the specified course from the user's enrolled courses list.
  /// Also updates the user's document in Firestore to reflect the removal.
  /// Additionally, removes all achievements associated with that course.
  ///
  /// [courseName] - Name of the course to remove
  Future<void> removeCourse(String courseName) async {
    enrolledCourses.removeWhere((course) => course.name == courseName);

    // Update Firestore with the removal
    final user = _auth.currentUser;
    if (user != null) {
      try {
        // Remove the course from user's enrolled courses
        await _userService.removeUserFromCourse(user.uid, courseName);

        // Remove all achievements for this course
        await _userService.removeUserAchievementsForCourse(
            user.uid, courseName);

        // Update local achievements list
        achievements
            .removeWhere((achievement) => achievement.courseName == courseName);

        print(
            'Successfully removed user ${user.uid} from course $courseName and deleted all related achievements');
      } catch (e) {
        print('Error removing user ${user.uid} from course $courseName: $e');
        // Note: We don't re-add to local list here as the UI operation should succeed
      }
    }
  }

  /// Loads user's enrolled courses from Firestore
  ///
  /// Fetches the user's enrolled courses from Firestore and populates
  /// the enrolledCourses list with the corresponding Course objects.
  Future<void> loadUserEnrolledCourses() async {
    final user = _auth.currentUser;
    if (user == null) {
      print('No user logged in, cannot load enrolled courses');
      return;
    }

    try {
      print('Loading enrolled courses for user: ${user.uid}');
      final enrolledCourseNames =
          await _userService.getUserEnrolledCourses(user.uid);
      print(
          'User is enrolled in ${enrolledCourseNames.length} courses: $enrolledCourseNames');

      // Debug: Print available courses
      print(
          'Available courses: ${availableCourses.map((c) => c.name).toList()}');

      // Clear current enrolled courses
      enrolledCourses.clear();

      // Find and add the corresponding Course objects
      for (String courseName in enrolledCourseNames) {
        // Use try/catch approach instead of firstWhereOrNull to avoid extension conflicts
        try {
          print('Looking for course: $courseName');
          final course =
              availableCourses.firstWhere((c) => c.name == courseName);
          enrolledCourses.add(course);
          print('Added enrolled course: $courseName');
        } catch (e) {
          print(
              'Warning: Could not find course data for enrolled course: $courseName');
          print(
              'Available course names: ${availableCourses.map((c) => c.name).toList()}');
        }
      }

      print(
          'Loaded ${enrolledCourses.length} enrolled courses for user ${user.uid}');
      print(
          'Enrolled courses list: ${enrolledCourses.map((c) => c.name).toList()}');
    } catch (e) {
      print('Error loading enrolled courses for user ${user.uid}: $e');
      // Re-throw the error so it can be caught by loadUserData
      rethrow;
    }
  }

  /// Adds a new achievement to the user's achievements
  ///
  /// Records a completed topic or subtopic as an achievement.
  /// Also updates the user's document in Firestore to reflect the new achievement.
  ///
  /// [achievement] - The achievement to add
  Future<void> addAchievement(Achievement achievement) async {
    achievements.add(achievement);

    // Update Firestore with the new achievement
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _userService.addUserAchievement(user.uid, achievement);
        print(
            'Successfully added achievement for user ${user.uid}: ${achievement.topicName}');
      } catch (e) {
        print('Error adding achievement for user ${user.uid}: $e');
        // Remove from local list if Firestore update failed
        achievements.remove(achievement);
        rethrow;
      }
    }
  }

  /// Loads user's achievements from Firestore
  ///
  /// Fetches the user's achievements from Firestore and populates
  /// the achievements list.
  Future<void> loadUserAchievements() async {
    final user = _auth.currentUser;
    if (user == null) {
      print('No user logged in, cannot load achievements');
      return;
    }

    try {
      print('Loading achievements for user: ${user.uid}');
      final userAchievements = await _userService.getUserAchievements(user.uid);
      print(
          'Found ${userAchievements.length} achievements for user ${user.uid}');

      // Clear current achievements and add the ones from Firestore
      achievements.assignAll(userAchievements);

      print('Loaded ${achievements.length} achievements for user ${user.uid}');
    } catch (e) {
      print('Error loading achievements for user ${user.uid}: $e');
      // Re-throw the error so it can be caught by loadUserData
      rethrow;
    }
  }

  /// Loads all user data including enrolled courses and achievements
  ///
  /// Fetches both the user's enrolled courses and achievements from Firestore.
  /// This method implements lazy loading by not blocking the UI.
  Future<void> loadUserData() async {
    try {
      print('Starting to load user data');
      // Load user data in parallel for better performance
      await Future.wait([loadUserEnrolledCourses(), loadUserAchievements()]);
      print('User data loading completed successfully');
    } catch (e) {
      print('Error loading user data: $e');
      // Don't rethrow to prevent app crashes - data will be loaded on demand
    }
  }

  /// Gets a course by name from available courses
  ///
  /// Returns a course from the available courses list by its name.
  ///
  /// [courseName] - Name of the course to find
  Course? getCourseByName(String courseName) {
    try {
      return availableCourses.firstWhere((course) => course.name == courseName);
    } catch (e) {
      return null;
    }
  }

  /// Calculates the total number of subtopics in a course
  ///
  /// Returns the total count of subtopics across all topics in the specified course.
  /// For topics without subtopics, counts as 1.
  ///
  /// [courseName] - Name of the course to calculate subtopics for
  int getTotalSubtopicsForCourse(String courseName) {
    try {
      final course = availableCourses.firstWhere((c) => c.name == courseName);
      int total = 0;
      for (var topic in course.topics) {
        total += topic.subtopics.isNotEmpty ? topic.subtopics.length : 1;
      }
      return total;
    } catch (e) {
      return 0;
    }
  }

  /// Calculates the number of completed subtopics in a course
  ///
  /// Returns the count of subtopics the user has completed in the specified course.
  ///
  /// [courseName] - Name of the course to calculate completed subtopics for
  int getCompletedSubtopicsForCourse(String courseName) {
    try {
      final course = availableCourses.firstWhere((c) => c.name == courseName);
      int completed = 0;
      final courseAchievements =
          achievements.where((a) => a.courseName == courseName).toList();

      for (var achievement in courseAchievements) {
        // Check if achievement is for a subtopic
        bool isSubtopic = false;
        for (var topic in course.topics) {
          for (var subtopic in topic.subtopics) {
            // For subtopic achievements, the topicName is formatted as "Topic - Subtopic"
            if (achievement.topicName.contains(' - ')) {
              final parts = achievement.topicName.split(' - ');
              if (parts.length == 2 && parts[1] == subtopic.name) {
                completed++;
                isSubtopic = true;
                break;
              }
            } else if (subtopic.name == achievement.topicName) {
              // Direct match (backward compatibility)
              completed++;
              isSubtopic = true;
              break;
            }
          }
          if (isSubtopic) break;
        }

        // If not a subtopic, it's a main topic (count as 1)
        if (!isSubtopic) {
          for (var topic in course.topics) {
            if (topic.name == achievement.topicName &&
                topic.subtopics.isEmpty) {
              completed++;
              break;
            }
          }
        }
      }

      return completed;
    } catch (e) {
      return 0;
    }
  }

  /// Calculates overall progress based on subtopics across all courses
  ///
  /// Returns the user's overall progress as a percentage based on completed
  /// subtopics across all enrolled courses.
  double getOverallProgressBySubtopics() {
    int totalSubtopics = 0;
    int completedSubtopics = 0;

    for (var course in enrolledCourses) {
      totalSubtopics += getTotalSubtopicsForCourse(course.name);
      completedSubtopics += getCompletedSubtopicsForCourse(course.name);
    }

    if (totalSubtopics == 0) return 0.0;
    return (completedSubtopics / totalSubtopics) * 100;
  }
}
