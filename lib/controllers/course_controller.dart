import 'package:get/get.dart';

class Course {
  final String name;
  final String description;
  final List<String> topics;
  final String icon;

  Course({
    required this.name,
    required this.description,
    required this.topics,
    required this.icon,
  });
}

class CourseController extends GetxController {
  var enrolledCourses = <Course>[].obs;

  void enrollCourse(Course course) {
    // Check if course is already enrolled
    if (!isCourseEnrolled(course.name)) {
      enrolledCourses.add(course);
    }
  }

  bool isCourseEnrolled(String courseName) {
    return enrolledCourses.any((course) => course.name == courseName);
  }

  void removeCourse(String courseName) {
    enrolledCourses.removeWhere((course) => course.name == courseName);
  }
}
