import 'package:get/get.dart';

class Subtopic {
  final String name;
  final String description;
  final String tutorialLink;
  final List<QuizQuestion> quizQuestions;

  Subtopic({
    required this.name,
    required this.description,
    required this.tutorialLink,
    required this.quizQuestions,
  });
}

class Topic {
  final String name;
  final String description;
  final String tutorialLink;
  final List<QuizQuestion> quizQuestions;
  final List<Subtopic> subtopics; // Add subtopics
  final bool isCompleted;

  Topic({
    required this.name,
    required this.description,
    required this.tutorialLink,
    required this.quizQuestions,
    this.subtopics = const [], // Initialize with empty list
    this.isCompleted = false,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class Achievement {
  final String topicName;
  final String courseName;
  final DateTime dateCompleted;

  Achievement({
    required this.topicName,
    required this.courseName,
    required this.dateCompleted,
  });
}

class Course {
  final String name;
  final String description;
  final List<Topic> topics;
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
  var achievements = <Achievement>[].obs;

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

  void addAchievement(Achievement achievement) {
    achievements.add(achievement);
  }

  // Calculate total subtopics for a course
  int getTotalSubtopicsForCourse(String courseName) {
    try {
      final course = enrolledCourses.firstWhere((c) => c.name == courseName);
      int total = 0;
      for (var topic in course.topics) {
        total += topic.subtopics.isNotEmpty ? topic.subtopics.length : 1;
      }
      return total;
    } catch (e) {
      return 0;
    }
  }

  // Calculate completed subtopics for a course
  int getCompletedSubtopicsForCourse(String courseName) {
    try {
      final course = enrolledCourses.firstWhere((c) => c.name == courseName);
      int completed = 0;
      final courseAchievements = achievements
          .where((a) => a.courseName == courseName)
          .toList();

      for (var achievement in courseAchievements) {
        // Check if achievement is for a subtopic
        bool isSubtopic = false;
        for (var topic in course.topics) {
          for (var subtopic in topic.subtopics) {
            // For subtopic achievements, the topicName is formatted as "Topic - Subtopic"
            if (achievement.topicName.contains(' - ')) {
              final parts = achievement.topicName.split(' - ');
              if (parts.length == 2 && parts[1] == subtopic.name) {
                completed++;
                isSubtopic = true;
                break;
              }
            } else if (subtopic.name == achievement.topicName) {
              // Direct match (backward compatibility)
              completed++;
              isSubtopic = true;
              break;
            }
          }
          if (isSubtopic) break;
        }

        // If not a subtopic, it's a main topic (count as 1)
        if (!isSubtopic) {
          for (var topic in course.topics) {
            if (topic.name == achievement.topicName &&
                topic.subtopics.isEmpty) {
              completed++;
              break;
            }
          }
        }
      }

      return completed;
    } catch (e) {
      return 0;
    }
  }

  // Calculate overall progress based on subtopics across all courses
  double getOverallProgressBySubtopics() {
    int totalSubtopics = 0;
    int completedSubtopics = 0;

    for (var course in enrolledCourses) {
      totalSubtopics += getTotalSubtopicsForCourse(course.name);
      completedSubtopics += getCompletedSubtopicsForCourse(course.name);
    }

    if (totalSubtopics == 0) return 0.0;
    return (completedSubtopics / totalSubtopics) * 100;
  }
}
