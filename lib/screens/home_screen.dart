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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: const Color(0xFF64748B)),
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
          BoxShadow(color: const Color(0xFF64748B).withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.school_outlined, size: 48, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          const Text('No enrolled courses yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          const Text('Enroll in courses to start your learning journey', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF64748B))),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 650;
    
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 1, // Single column for both, but different internal layouts
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isMobile ? 1.15 : 2.8, // Taller portrait for mobile, wide landscape for web
      ),
      itemCount: courseController.availableCourses.length,
      itemBuilder: (context, index) {
        final course = courseController.availableCourses[index];
        final isEnrolled = courseController.isCourseEnrolled(course.name);

        final imageSection = Container(
          width: isMobile ? double.infinity : null,
          height: isMobile ? null : double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (course.imageUrl.isNotEmpty)
                Image.network(
                  course.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(_getIconForCourse(course.name), size: 48, color: Theme.of(context).colorScheme.primary),
                  ),
                )
              else
                Center(
                  child: Icon(_getIconForCourse(course.name), size: 48, color: Theme.of(context).colorScheme.primary),
                ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: isMobile ? Alignment.topCenter : Alignment.centerLeft,
                    end: isMobile ? Alignment.bottomCenter : Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(isMobile ? 0.2 : 0.05),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

        final textSection = Padding(
          padding: EdgeInsets.all(isMobile ? 14.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900, 
                      fontSize: isMobile ? 18 : 22, // Scale down for mobile
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                      letterSpacing: -0.4,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isMobile ? 4 : 8),
                  Text(
                    course.description.isNotEmpty ? course.description : 'Explore comprehensive tutorials and guides for ${course.name}.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: isMobile ? 13 : 14.5,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                      height: 1.4,
                    ),
                    maxLines: isMobile ? 2 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: isMobile ? 8 : 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isEnrolled 
                          ? [const Color(0xFF22C55E), const Color(0xFF16A34A)]
                          : [Theme.of(context).colorScheme.primary, const Color(0xFF1D4ED8)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: (isEnrolled ? const Color(0xFF22C55E) : Theme.of(context).colorScheme.primary).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    isEnrolled ? 'Continue Learning' : 'View Details',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: isMobile ? 12.5 : 13.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        return GestureDetector(
          onTap: () {
            Get.to(() => CourseDetailsScreen(
              courseName: course.name,
              courseDescription: course.description,
              topics: course.topicNames,
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFE2E8F0),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black.withOpacity(0.4) : const Color(0xFF64748B).withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: isMobile 
                ? Column( // Vertical stack for mobile
                    children: [
                      Expanded(flex: 50, child: imageSection),
                      Expanded(flex: 50, child: textSection),
                    ],
                  )
                : Row( // Horizontal layout for web
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 35, child: imageSection),
                      Expanded(flex: 65, child: textSection),
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
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
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
                    Text('Enrolled in:', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    Text(enrolledCourse, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('on $enrollmentDate', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
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
