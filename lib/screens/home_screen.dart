// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/home_screen_controller.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
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
    final Map<String, Map<String, dynamic>> courseDetails = CourseDetailsJsonData().courseDetails;

    const String enrolledCourse = 'Flutter';
    const String enrollmentDate = '24, July 2024';
    const String userName = "Alex";

    final ThemeController themeController = Get.find<ThemeController>();
    final HomeScreenController homeScreenController =
        Get.find<HomeScreenController>();
    // homeScreenController.courseProgress = 99.9.obs;

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
                    // Progress Card
                    buildProgressCard(
                      themeController,
                      homeScreenController,
                      context,
                      enrolledCourse,
                      enrollmentDate,
                    ),

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
                            Get.to(
                              () => CourseDetailsScreen(
                                courseName: course,
                                courseDescription: details['description'],
                                topics: List<String>.from(details['topics']),
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

  // Course Progress Card
  Widget buildProgressCard(
    ThemeController themeController,
    HomeScreenController homeScreenController,
    BuildContext context,
    String enrolledCourse,
    String enrollmentDate,
  ) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;
      final progress = homeScreenController.courseProgress.value;

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
                  progress: progress, // now in 0–100 range
                  strokeWidth: 8,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  child: Center(
                    child: Text(
                      '${progress.toStringAsFixed(1)}%',
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
