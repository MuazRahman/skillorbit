import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/controllers/auth_controller.dart';
import 'package:skillorbit/controllers/dashboard_controller.dart';
import 'package:skillorbit/core/app_color.dart';
import 'package:skillorbit/models/course_model.dart';
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
                            errorBuilder: (context, error, stackTrace) =>
                                Container(), // Fallback to gradient
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
                                  ? SvgPicture.asset(course.icon,
                                      color: Colors.white)
                                  : Image.asset(course.icon))
                              : const Icon(Icons.school,
                                  size: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(courseName,
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      const Text('Master this technology',
                          style:
                              TextStyle(fontSize: 16, color: Colors.white70)),
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
                  const Text('About this course',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(courseDescription, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  const Text('What you\'ll learn',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  if (course != null)
                    FutureBuilder<List<Module>>(
                      future: courseController.getModulesForCourse(course.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ));
                        }
                        
                        final modules = snapshot.data ?? [];

                        if (modules.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: modules.length,
                            itemBuilder: (context, index) {
                              final module = modules[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFF64748B).withOpacity(0.15),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      module.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800, 
                                        fontSize: 18, // Much larger module name
                                      ),
                                    ),
                                    if (module.description.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        module.description,
                                        maxLines: 2, // Ensure it remains a short description
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          color: Theme.of(context).brightness == Brightness.dark 
                                              ? const Color(0xFF94A3B8) 
                                              : const Color(0xFF475569),
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        
                        if (topics.isNotEmpty) {
                          return GridView.builder(
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
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color(0xFF64748B).withOpacity(0.2)),
                                ),
                                child: Center(
                                    child: Text(
                                  topics[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16), // Made legacy topics bigger too
                                )),
                              );
                            },
                          );
                        }

                        return const Text('Module list coming soon.', style: TextStyle(fontSize: 16));
                      },
                    )
                  else if (topics.isEmpty)
                    const Text('Module list coming soon.', style: TextStyle(fontSize: 16))
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFF64748B).withOpacity(0.2)),
                          ),
                          child: Center(
                              child: Text(topics[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))), // Made fallback topics bigger
                        );
                      },
                    ),
                  const SizedBox(height: 32),
                  Obx(() {
                    final isEnrolled =
                        courseController.isCourseEnrolled(courseName);

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
                                final DashBoardController dashboardController =
                                    Get.find<DashBoardController>();
                                dashboardController.currentPageIndex.value = 1;
                                Get.offAll(() => const DashboardScreen());
                                return;
                              }

                              // Await the enrollment to ensure Firestore is updated before we navigate
                              await courseController.enrollCourse(course);

                              // Set dashboard index to 1 (My Course) before navigating
                              final DashBoardController dashboardController =
                                  Get.find<DashBoardController>();
                              dashboardController.currentPageIndex.value = 1;

                              Get.snackbar(
                                  'Success', 'Enrolled in $courseName');

                              // Use direct navigation to be more robust against routing issues
                              Get.offAll(() => const DashboardScreen());
                            } catch (e) {
                              print('Enrollment navigation error: $e');
                              Get.snackbar('Error',
                                  'Enrollment succeeded but navigation failed. Please go to My Courses manually.');
                              Get.offAllNamed('/dashboard'); // Fallback
                            }
                          } else {
                            Get.snackbar('Error',
                                'Course data not found. Please try again.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isEnrolled
                              ? const Color(0xFF22C55E)
                              : const Color(0xFF2563EB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(
                          isEnrolled
                              ? 'Already Enrolled - Go to Course'
                              : 'Enroll Now',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
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
