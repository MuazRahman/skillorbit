import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/core/app_color.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseName;
  final String courseDescription;
  final List<String> topics;

  const CourseDetailsScreen({
    super.key,
    required this.courseName,
    required this.courseDescription,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    // Get the course controller
    final courseController = Get.find<CourseController>();

    // Find the course to get its icon
    final course = courseController.getCourseByName(courseName);

    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName Course'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: course != null && course.icon.isNotEmpty
                          ? (course.icon.contains('.svg')
                                ? SvgPicture.asset(
                                    course.icon,
                                    fit: BoxFit.contain,
                                  )
                                : course.icon.contains('.png')
                                ? Image.asset(course.icon, fit: BoxFit.contain)
                                : Text(
                                    _getIconForCourse(courseName),
                                    style: const TextStyle(fontSize: 48),
                                  ))
                          : Text(
                              _getIconForCourse(courseName),
                              style: const TextStyle(fontSize: 48),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    courseName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Master this technology',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About this course',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      courseDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Topics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What you\'ll learn',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Topics Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2,
                        ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              topics[index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Enrollment Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Check if course is already enrolled
                    if (courseController.isCourseEnrolled(courseName)) {
                      // Show message that course is already added
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '$courseName is already in your courses!',
                          ),
                          backgroundColor: Colors.orange,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      // Find the course in available courses
                      final course = courseController.getCourseByName(
                        courseName,
                      );

                      if (course != null) {
                        // Add course to enrolled courses
                        courseController.enrollCourse(course);

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$courseName has been added to your courses!',
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else {
                        // Show error message if course not found
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Course $courseName not found!'),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor:
                        AppColor.lightPrimary, // Use the correct color property
                  ),
                  child: const Text(
                    'Enroll Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getIconForCourse(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'flutter':
        return '📱';
      case 'c':
        return '💻';
      case 'c++':
        return '⚡';
      case 'java':
        return '☕';
      case 'database':
        return '🗄️';
      case 'mysql':
        return '🐬';
      case 'html':
        return '🌐';
      case 'python':
        return '🐍';
      case 'react':
        return '⚛️';
      case 'dart':
        return '🎯';
      default:
        return '📚';
    }
  }
}
