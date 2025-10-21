import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/course_details_screen.dart';

void main() {
  setUp(() {
    // Initialize the course controller before each test
    Get.put(CourseController());
  });

  tearDown(() {
    // Remove the course controller after each test
    Get.delete<CourseController>();
  });

  testWidgets('CourseDetailsScreen displays course information', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: CourseDetailsScreen(
          courseName: 'Flutter',
          courseDescription: 'Learn Flutter development',
          topics: ['Widgets', 'State Management', 'Navigation'],
        ),
      ),
    );

    // Verify that the course name is displayed
    expect(find.text('Flutter'), findsOneWidget);

    // Verify that the course description is displayed
    expect(find.text('Learn Flutter development'), findsOneWidget);

    // Verify that topics are displayed
    expect(find.text('Widgets'), findsOneWidget);
    expect(find.text('State Management'), findsOneWidget);
    expect(find.text('Navigation'), findsOneWidget);

    // Verify that the enroll button is displayed
    expect(find.text('Enroll Now'), findsOneWidget);
  });

  testWidgets('CourseController can enroll courses', (
    WidgetTester tester,
  ) async {
    // Get the course controller
    final courseController = Get.find<CourseController>();

    // Verify initial state
    expect(courseController.enrolledCourses.length, 0);

    // Create a course and enroll it
    final course = Course(
      name: 'Flutter',
      description: 'Learn Flutter development',
      topics: ['Widgets', 'State Management', 'Navigation'],
      icon: '📱',
    );

    // Enroll the course
    courseController.enrollCourse(course);

    // Verify that the course was added to enrolled courses
    expect(courseController.enrolledCourses.length, 1);
    expect(courseController.enrolledCourses[0].name, 'Flutter');
  });

  testWidgets('CourseController can detect already enrolled courses', (
    WidgetTester tester,
  ) async {
    // Get the course controller
    final courseController = Get.find<CourseController>();

    // Add a course first
    final course = Course(
      name: 'Flutter',
      description: 'Learn Flutter development',
      topics: ['Widgets', 'State Management', 'Navigation'],
      icon: '📱',
    );

    // Enroll the course
    courseController.enrollCourse(course);

    // Verify initial state
    expect(courseController.enrolledCourses.length, 1);

    // Check if the course is already enrolled
    expect(courseController.isCourseEnrolled('Flutter'), true);
    expect(courseController.isCourseEnrolled('Dart'), false);
  });
}
