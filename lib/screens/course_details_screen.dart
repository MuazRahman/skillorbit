import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/controllers/auth_controller.dart';
import 'package:skillorbit/controllers/dashboard_controller.dart';
import 'package:skillorbit/core/app_color.dart';
import 'package:skillorbit/screens/auth/login_screen.dart';
import 'package:skillorbit/screens/dashboard_screen.dart';

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
    final courseController = Get.find<CourseController>();
    final authController = Get.find<AuthController>();
    final course = courseController.getCourseByName(courseName);

    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName Course'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: (course != null && course.imageUrl.isNotEmpty)
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.network(
                            course.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(), // Fallback to gradient
                          ),
                        )
                      : null,
                ),
                // Overlay for better text readability
                if (course != null && course.imageUrl.isNotEmpty)
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: (course != null && course.icon.isNotEmpty)
                              ? (course.icon.contains('.svg')
                                  ? SvgPicture.asset(course.icon, color: Colors.white)
                                  : Image.asset(course.icon))
                              : const Icon(Icons.school, size: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(courseName, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 8),
                      const Text('Master this technology', style: TextStyle(fontSize: 16, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About this course', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(courseDescription, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  const Text('What you\'ll learn', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  if (topics.isEmpty)
                    const Text('Module list coming soon.')
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: Center(child: Text(topics[index], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500))),
                        );
                      },
                    ),
                  const SizedBox(height: 32),
                  Obx(() {
                    final isEnrolled = courseController.isCourseEnrolled(courseName);
                    
                    return SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!authController.isLoggedIn.value) {
                            Get.to(() => const LoginScreen());
                            return;
                          }
                          
                          if (course != null) {
                            try {
                              if (isEnrolled) {
                                // Already enrolled, just take them to My Courses
                                final DashBoardController dashboardController = Get.find<DashBoardController>();
                                dashboardController.currentPageIndex.value = 1;
                                Get.offAll(() => const DashboardScreen());
                                return;
                              }

                              // Await the enrollment to ensure Firestore is updated before we navigate
                              await courseController.enrollCourse(course);
                              
                              // Set dashboard index to 1 (My Course) before navigating
                              final DashBoardController dashboardController = Get.find<DashBoardController>();
                              dashboardController.currentPageIndex.value = 1;
                              
                              Get.snackbar('Success', 'Enrolled in $courseName');
                              
                              // Use direct navigation to be more robust against routing issues
                              Get.offAll(() => const DashboardScreen());
                            } catch (e) {
                              print('Enrollment navigation error: $e');
                              Get.snackbar('Error', 'Enrollment succeeded but navigation failed. Please go to My Courses manually.');
                              Get.offAllNamed('/dashboard'); // Fallback
                            }
                          } else {
                            Get.snackbar('Error', 'Course data not found. Please try again.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isEnrolled ? Colors.green : AppColor.lightPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(
                          isEnrolled ? 'Already Enrolled - Go to Course' : 'Enroll Now',
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
