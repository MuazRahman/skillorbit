import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/enrolled_course_screen.dart';
import 'package:skillorbit/widgets/course_icon_widget.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Load user's enrolled courses when the screen is opened
    _loadUserEnrolledCourses();
  }

  /// Load user's enrolled courses from Firestore
  Future<void> _loadUserEnrolledCourses() async {
    try {
      final courseController = Get.find<CourseController>();
      print('MyCourseScreen: Starting to load user data');
      // Use lazy loading - don't await the future to prevent UI blocking
      courseController.loadUserData();
      print('MyCourseScreen: Started loading user data in background');
    } catch (e) {
      print('MyCourseScreen: Error starting user data loading: $e');
      if (mounted) {
        Get.snackbar(
          'Error',
          'Failed to load your data. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  /// Refresh enrolled courses from Firestore
  Future<void> _refreshEnrolledCourses() async {
    try {
      final courseController = Get.find<CourseController>();
      print('MyCourseScreen: Refreshing all data');
      // Clear all caches and reload from Firestore
      await courseController.refreshAllData();
      print('MyCourseScreen: Refreshed all data successfully');

      // Force a rebuild of the widget to update the UI
      setState(() {});

      if (mounted) {
        Get.snackbar(
          'Refreshed',
          'Your courses have been updated!',
          backgroundColor: const Color(0xFF22C55E),
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      print('MyCourseScreen: Error refreshing courses: $e');
      if (mounted) {
        Get.snackbar(
          'Error',
          'Failed to refresh courses. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();

    return TopRoundCornerScreen(
      child: Obx(() {
        if (courseController.enrolledCourses.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book_outlined,
                    size: 80, color: const Color(0xFF64748B)),
                SizedBox(height: 16),
                Text(
                  'No courses enrolled yet',
                  style: TextStyle(fontSize: 18, color: Color(0xFF64748B)),
                ),
                SizedBox(height: 8),
                Text(
                  'Enroll in courses from the home screen',
                  style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Courses',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton(
                    icon: Icon(_isEditing ? Icons.done : Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshEnrolledCourses,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate card size to make them square
                      final cardWidth =
                          (constraints.maxWidth - 16) / 2; // Subtract spacing
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: courseController.enrolledCourses.length,
                        itemBuilder: (context, index) {
                          final course =
                              courseController.enrolledCourses[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_isEditing) return; // Prevent accidental navigation while trying to delete
                                  Get.to(
                                    () => EnrolledCourseScreen(course: course),
                                  );
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    height:
                                        cardWidth, // Make height equal to width for square shape
                                    width: cardWidth,
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Display course icon
                                        Expanded(
                                          child: CourseIconWidget(
                                            iconPath: course.icon,
                                            size: double.infinity,
                                            iconSize: 40,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          course.name,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (_isEditing)
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      onPressed: () {
                                        // Remove the course
                                        courseController.removeCourse(
                                          course.name,
                                        );
                                        setState(() {
                                          // Refresh the UI
                                        });
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
