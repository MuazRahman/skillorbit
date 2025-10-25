// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/home_screen_controller.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/course_details_screen.dart';
import 'package:skillorbit/services/demo_course_details_json_data.dart';
import 'package:skillorbit/widgets/gradient_circular_progress_indicator_widget.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final courses = [
      'Flutter',
      'C',
      'C++',
      'Java',
      'Database',
      'MySQL',
      'HTML',
      'Python',
      'React',
      'Dart',
    ];

    // Course details data
    final Map<String, Map<String, dynamic>> courseDetails =
        CourseDetailsJsonData().courseDetails;

    const String userName = "Alex";

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
            // Header
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

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enrolled Courses Progress Cards - Show all enrolled courses
                    Obx(() {
                      if (courseController.enrolledCourses.isEmpty) {
                        // Show a message when no courses are enrolled instead of a default course
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
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Enroll in courses to start your learning journey',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Show progress cards for all enrolled courses
                        return Column(
                          children: courseController.enrolledCourses.map((
                            course,
                          ) {
                            // Calculate progress for this course (simplified calculation)
                            // In a real app, this would be based on completed topics/achievements
                            final progress = _calculateCourseProgress(
                              course,
                              courseController,
                            );

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
                    }),

                    const SizedBox(height: 16),

                    // Search Bar
                    buildSearchBar(context),

                    const SizedBox(height: 16),

                    // Courses Section
                    Text(
                      'Courses',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    // Courses Grid
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        final details = courseDetails[course]!;
                        return GestureDetector(
                          onTap: () {
                            // Extract topics data properly
                            List<String> topicsList = [];
                            final topicsData = details['topics'];

                            if (topicsData is List) {
                              if (topicsData.isNotEmpty &&
                                  topicsData.first is Map<String, dynamic>) {
                                // New format with detailed topics
                                topicsList =
                                    (topicsData as List<Map<String, dynamic>>)
                                        .map((topic) => topic['name'] as String)
                                        .toList();
                              } else if (topicsData.first is String) {
                                // Old format with simple string topics
                                topicsList = List<String>.from(topicsData);
                              }
                            }

                            Get.to(
                              () => CourseDetailsScreen(
                                courseName: course,
                                courseDescription: details['description'],
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
                                color: Theme.of(context).dividerColor,
                                width: 0.3,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _getIconForCourse(courses[index]),
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  courses[index],
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
  Widget buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for courses...',
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
    );
  }

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
