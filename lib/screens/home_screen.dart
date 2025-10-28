// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillorbit/controllers/home_screen_controller.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/models/course_model.dart';
import 'package:skillorbit/screens/course_details_screen.dart';
import 'package:skillorbit/widgets/gradient_circular_progress_indicator_widget.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

/// Main home screen widget that displays the user dashboard
///
/// This widget shows:
/// - User welcome message
/// - Enrolled course progress
/// - Available courses for enrollment
///
/// It uses GetX for state management and follows the MVC pattern
/// by delegating data operations to controllers.
class HomeScreen extends StatelessWidget {
  /// Creates a HomeScreen widget
  ///
  /// [key] - Optional widget key
  const HomeScreen({super.key});

  /// Gets the appropriate icon for a course based on its name
  ///
  /// Returns a Material icon that represents the course subject.
  ///
  /// [courseName] - Name of the course to get an icon for
  IconData _getIconForCourse(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android;
      case 'c':
      case 'c++':
        return Icons.code_sharp;
      case 'java':
        return Icons.coffee_outlined;
      case 'database':
        return Icons.storage_rounded;
      case 'mysql':
        return Icons.dns_outlined;
      case 'html':
        return Icons.web_asset;
      default:
        return Icons.school_outlined;
    }
  }

  /// Builds the main UI of the home screen
  ///
  /// This method constructs the complete home screen UI including:
  /// - Header with welcome message
  /// - Enrolled course progress cards
  /// - Grid of available courses
  ///
  /// [context] - Build context for the widget
  @override
  Widget build(BuildContext context) {
    // Default user name (in a real app, this would come from user data)
    const String userName = "Alex";

    // Get required controllers using GetX dependency injection
    final ThemeController themeController = Get.find<ThemeController>();
    final HomeScreenController homeScreenController =
        Get.find<HomeScreenController>();
    final CourseController courseController = Get.find<CourseController>();

    return TopRoundCornerScreen(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === HEADER SECTION ===
            // Display welcome message and user name
            Text(
              'Welcome back,',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
            ),
            Text(
              userName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            // === MAIN CONTENT AREA ===
            // Scrollable content area containing course information
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // === ENROLLED COURSES PROGRESS ===
                    // Display progress cards for all enrolled courses
                    Obx(() {
                      // Show message when no courses are enrolled
                      if (courseController.enrolledCourses.isEmpty) {
                        return _buildNoCoursesMessage(context);
                      } else {
                        // Show progress cards for all enrolled courses
                        return _buildEnrolledCoursesProgress(
                          context,
                          courseController,
                          themeController,
                          homeScreenController,
                        );
                      }
                    }),

                    const SizedBox(height: 16),

                    // === AVAILABLE COURSES SECTION ===
                    // Header for the courses section
                    Text(
                      'Available Courses',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    // Grid of available courses
                    _buildAvailableCoursesGrid(context, courseController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the message displayed when no courses are enrolled
  ///
  /// [context] - Build context for the widget
  Widget _buildNoCoursesMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.school_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'No enrolled courses yet',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Enroll in courses to start your learning journey',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// Builds progress cards for all enrolled courses
  ///
  /// [context] - Build context for the widget
  /// [courseController] - Controller managing course data
  /// [themeController] - Controller managing theme settings
  /// [homeScreenController] - Controller managing home screen state
  Widget _buildEnrolledCoursesProgress(
    BuildContext context,
    CourseController courseController,
    ThemeController themeController,
    HomeScreenController homeScreenController,
  ) {
    return Column(
      children: courseController.enrolledCourses.map((course) {
        // Calculate progress for this course (simplified calculation)
        // In a real app, this would be based on completed topics/achievements
        final progress = _calculateCourseProgress(course, courseController);

        return buildProgressCard(
          themeController,
          homeScreenController,
          context,
          course.name,
          'Recently enrolled', // You might want to store actual enrollment dates
          progress: progress, // Pass real progress value
        );
      }).toList(),
    );
  }

  /// Builds the grid of available courses
  ///
  /// [context] - Build context for the widget
  /// [courseController] - Controller managing course data
  Widget _buildAvailableCoursesGrid(
    BuildContext context,
    CourseController courseController,
  ) {
    return Obx(() {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: courseController.availableCourses.length,
        itemBuilder: (context, index) {
          final course = courseController.availableCourses[index];
          final isEnrolled = courseController.isCourseEnrolled(course.name);

          List<String> topicsList = [];
          if (course.hasDetailedTopics) {
            // For detailed courses, extract topic names
            topicsList = course.topics.map((t) => t.name).toList();
          } else {
            // For simple courses, use topicNames
            topicsList = course.topicNames;
          }

          return GestureDetector(
            onTap: () {
              // Navigate to Course Details Screen for all courses
              // Enrollment will happen in the course details screen
              Get.to(
                () => CourseDetailsScreen(
                  courseName: course.name,
                  courseDescription: course.description,
                  topics: topicsList,
                ),
              );
            },
            child: Card(
              elevation: 2,
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isEnrolled
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).dividerColor,
                  width: isEnrolled ? 2 : 0.3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      // Display course icon as an image
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: course.icon.isNotEmpty
                            ? (course.icon.contains('.svg')
                                  ? SvgPicture.asset(
                                      course.icon,
                                      fit: BoxFit.contain,
                                      placeholderBuilder: (context) => Icon(
                                        _getIconForCourse(course.name),
                                        size: 40,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    )
                                  : course.icon.contains('.png')
                                  ? Image.asset(
                                      course.icon,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) => Icon(
                                        _getIconForCourse(course.name),
                                        size: 40,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    )
                                  : Icon(
                                      _getIconForCourse(course.name),
                                      size: 40,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ))
                            : Icon(
                                _getIconForCourse(course.name),
                                size: 40,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      ),
                      if (isEnrolled)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    course.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEnrolled ? 'Enrolled' : 'View Details',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isEnrolled
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  // Helper method to check if migration is needed
  Future<bool> _checkIfMigrationNeeded() async {
    try {
      // Check if we have courses in Firestore
      final firestore = FirebaseFirestore.instance;
      final coursesSnapshot = await firestore
          .collection('courses')
          .limit(1)
          .get();

      // If we have no courses in Firestore, migration is needed
      return coursesSnapshot.size == 0;
    } catch (e) {
      print('Error checking if migration is needed: $e');
      // If there's an error, assume migration is needed
      return true;
    }
  }

  // Helper method to calculate course progress
  double _calculateCourseProgress(
    Course course,
    CourseController courseController,
  ) {
    // Count achievements for this course
    final courseAchievements = courseController.achievements
        .where((achievement) => achievement.courseName == course.name)
        .length;

    // Calculate progress based on completed topics vs total topics
    if (course.topics.isEmpty) return 0.0;

    // Progress is based on achievements earned for this course
    final progress = (courseAchievements / course.topics.length) * 100;
    return progress.clamp(0.0, 100.0);
  }

  // Search Box
  // Widget buildSearchBar(BuildContext context) {
  //   return TextField(
  //     decoration: InputDecoration(
  //       hintText: 'Search for courses...',
  //       prefixIcon: Icon(
  //         Icons.search,
  //         color: Theme.of(context).colorScheme.primary,
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(
  //           color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
  //         ),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
  //       ),
  //       filled: true,
  //       fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
  //     ),
  //   );
  // }

  // Updated Course Progress Card to accept progress parameter
  Widget buildProgressCard(
    ThemeController themeController,
    HomeScreenController homeScreenController,
    BuildContext context,
    String enrolledCourse,
    String enrollmentDate, {
    double progress = 80.5, // Default progress value
  }) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;
      final progressInt = progress.toInt();

      return Card(
        elevation: 3,
        color: isDarkMode
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: GradientCircularProgressIndicator(
                  progress: progress, // Use passed progress value
                  strokeWidth: 8,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Text(
                      '$progressInt%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enrolled in:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      enrolledCourse,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'on $enrollmentDate',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
