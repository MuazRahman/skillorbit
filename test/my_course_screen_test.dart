import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/my_course_screen.dart';

void main() {
  setUp(() {
    // Initialize the course controller before each test
    Get.put(CourseController());
  });

  tearDown(() {
    // Remove the course controller after each test
    Get.delete<CourseController>();
  });

  testWidgets('MyCourseScreen displays empty state', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MyCourseScreen()));

    // Verify that the empty state is displayed
    expect(find.text('No courses enrolled yet'), findsOneWidget);
    expect(find.text('Enroll in courses from the home screen'), findsOneWidget);
  });

  testWidgets('MyCourseScreen displays enrolled courses', (
    WidgetTester tester,
  ) async {
    // Get the course controller
    final courseController = Get.find<CourseController>();

    // Add some courses
    courseController.enrollCourse(
      Course(
        name: 'Flutter',
        description: 'Learn Flutter development',
        topics: ['Widgets', 'State Management', 'Navigation'],
        icon: '📱',
      ),
    );

    courseController.enrollCourse(
      Course(
        name: 'Dart',
        description: 'Learn Dart programming',
        topics: ['Syntax', 'OOP', 'Async Programming'],
        icon: '🎯',
      ),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MyCourseScreen()));

    // Verify that the courses are displayed
    expect(find.text('My Courses'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);

    // Verify that the edit button is present
    expect(find.byIcon(Icons.edit), findsOneWidget);
  });

  testWidgets('MyCourseScreen edit mode shows remove buttons', (
    WidgetTester tester,
  ) async {
    // Get the course controller
    final courseController = Get.find<CourseController>();

    // Add a course
    courseController.enrollCourse(
      Course(
        name: 'Flutter',
        description: 'Learn Flutter development',
        topics: ['Widgets', 'State Management', 'Navigation'],
        icon: '📱',
      ),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MyCourseScreen()));

    // Initially, there should be no close buttons
    expect(find.byIcon(Icons.close), findsNothing);

    // Tap the edit button
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();

    // Now there should be a close button
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(
      find.byIcon(Icons.done),
      findsOneWidget,
    ); // Edit button should change to done

    // Tap the close button to remove the course
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    // The course should be removed
    expect(courseController.enrolledCourses.length, 0);
  });
}
