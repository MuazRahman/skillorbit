import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/enrolled_course_screen.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  bool _isEditing = false;

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
                Icon(Icons.book_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No courses enrolled yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Enroll in courses from the home screen',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
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
                        final course = courseController.enrolledCourses[index];
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Display course icon as an image
                                      Expanded(
                                        child: course.icon.isNotEmpty
                                            ? (course.icon.contains('.svg')
                                                  ? SvgPicture.asset(
                                                      course.icon,
                                                      fit: BoxFit.contain,
                                                      placeholderBuilder:
                                                          (context) => Icon(
                                                            Icons.school,
                                                            size: 40,
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .primary,
                                                          ),
                                                    )
                                                  : course.icon.contains('.png')
                                                  ? Image.asset(
                                                      course.icon,
                                                      fit: BoxFit.contain,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => Icon(
                                                            Icons.school,
                                                            size: 40,
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .primary,
                                                          ),
                                                    )
                                                  : Icon(
                                                      Icons.school,
                                                      size: 40,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ))
                                            : Icon(
                                                Icons.school,
                                                size: 40,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
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
            ],
          ),
        );
      }),
    );
  }
}
