// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillorbit/controllers/auth_controller.dart';
import 'package:skillorbit/controllers/home_screen_controller.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/course_details_screen.dart';
import 'package:skillorbit/widgets/gradient_circular_progress_indicator_widget.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  IconData _getIconForCourse(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'flutter': return Icons.phone_android;
      case 'c':
      case 'c++': return Icons.code_sharp;
      case 'java': return Icons.coffee_outlined;
      case 'database': return Icons.storage_rounded;
      case 'mysql': return Icons.dns_outlined;
      case 'html': return Icons.web_asset;
      default: return Icons.school_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final ThemeController themeController = Get.find<ThemeController>();
    final HomeScreenController homeScreenController = Get.find<HomeScreenController>();
    final CourseController courseController = Get.find<CourseController>();

    return TopRoundCornerScreen(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
            ),
            Obx(
              () => Text(
                authController.userName.value.isNotEmpty ? authController.userName.value : 'Guest User',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      // Accessing the list itself to ensure Obx triggers on ANY change (add/remove)
                      final enrolledCount = courseController.enrolledCourses.length;
                      
                      if (enrolledCount == 0) {
                        return _buildNoCoursesMessage(context);
                      } else {
                        return _buildEnrolledCoursesProgress(context, courseController, themeController, homeScreenController);
                      }
                    }),
                    const SizedBox(height: 16),
                    Text(
                      'Available Courses',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildAvailableCoursesSection(context, courseController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoCoursesMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.school_outlined, size: 48, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          const Text('No enrolled courses yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          const Text('Enroll in courses to start your learning journey', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildEnrolledCoursesProgress(
    BuildContext context,
    CourseController courseController,
    ThemeController themeController,
    HomeScreenController homeScreenController,
  ) {
    return Column(
      children: courseController.enrolledCourses.map((course) {
        // Simplified progress for now (requires loading modules/topics for real calculation)
        double progress = 0.0;
        final achievements = courseController.achievements.where((a) => a.courseName == course.name).toList();
        if (achievements.isNotEmpty) {
           // This is just a placeholder logic; real progress requires total module/topic count
           progress = 10.0; // Placeholder
        }

        return buildProgressCard(
          themeController,
          homeScreenController,
          context,
          course.name,
          'Recently enrolled',
          progress: progress,
        );
      }).toList(),
    );
  }

  Widget _buildAvailableCoursesSection(BuildContext context, CourseController courseController) {
    return Obx(() {
      // Access enrolledCourses to ensure this Obx rebuilds when enrollment status changes
      final _ = courseController.enrolledCourses.length;
      
      if (courseController.isCoursesLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return _buildAvailableCoursesGrid(context, courseController);
    });
  }

  Widget _buildAvailableCoursesGrid(BuildContext context, CourseController courseController) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: courseController.availableCourses.length,
      itemBuilder: (context, index) {
        final course = courseController.availableCourses[index];
        final isEnrolled = courseController.isCourseEnrolled(course.name);

        return GestureDetector(
          onTap: () {
            Get.to(() => CourseDetailsScreen(
              courseName: course.name,
              courseDescription: course.description,
              topics: course.topicNames,
            ));
          },
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    ),
                    child: course.imageUrl.isNotEmpty
                        ? Image.network(
                            course.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Icon(_getIconForCourse(course.name), size: 30, color: Theme.of(context).colorScheme.primary),
                            ),
                          )
                        : Center(
                            child: Icon(_getIconForCourse(course.name), size: 30, color: Theme.of(context).colorScheme.primary),
                          ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          course.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isEnrolled ? 'Enrolled' : 'View Details',
                          style: TextStyle(
                            fontSize: 11,
                            color: isEnrolled ? Colors.green : Colors.grey,
                            fontWeight: isEnrolled ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProgressCard(
    ThemeController themeController,
    HomeScreenController homeScreenController,
    BuildContext context,
    String enrolledCourse,
    String enrollmentDate, {
    double progress = 0.0,
  }) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;
      return Card(
        elevation: 3,
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(value: progress / 100, strokeWidth: 6),
                    Text('${progress.toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enrolled in:', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(enrolledCourse, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('on $enrollmentDate', style: const TextStyle(fontSize: 11, color: Colors.grey)),
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

class _AnimatedDots extends StatelessWidget {
  const _AnimatedDots();
  @override
  Widget build(BuildContext context) => const SizedBox();
}
