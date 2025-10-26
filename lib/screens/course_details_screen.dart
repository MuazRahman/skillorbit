import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/core/app_color.dart';
import 'package:skillorbit/screens/enrolled_course_screen.dart';
import 'package:skillorbit/services/demo_course_details_json_data.dart';

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
                    child: Text(
                      _getIconForCourse(courseName),
                      style: const TextStyle(fontSize: 48),
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
                      // Create a course object with detailed topics
                      final courseData =
                          CourseDetailsJsonData().courseDetails[courseName];
                      List<Topic> topics = [];

                      if (courseData != null && courseData['topics'] is List) {
                        final topicData = courseData['topics'];
                        if (topicData is List<Map<String, dynamic>>) {
                          topics = topicData.map((topicMap) {
                            List<QuizQuestion> quizQuestions = [];
                            if (topicMap['quizQuestions'] is List) {
                              final quizData =
                                  topicMap['quizQuestions'] as List;
                              quizQuestions = quizData.map((q) {
                                return QuizQuestion(
                                  question: q['question'],
                                  options: List<String>.from(q['options']),
                                  correctAnswerIndex: q['correctAnswerIndex'],
                                );
                              }).toList();
                            }

                            // Handle subtopics if they exist
                            List<Subtopic> subtopics = [];
                            if (topicMap['subtopics'] is List) {
                              final subtopicData =
                                  topicMap['subtopics'] as List;
                              subtopics = subtopicData.map((subtopicMap) {
                                List<QuizQuestion> subtopicQuizQuestions = [];
                                if (subtopicMap['quizQuestions'] is List) {
                                  final quizData =
                                      subtopicMap['quizQuestions'] as List;
                                  subtopicQuizQuestions = quizData.map((q) {
                                    return QuizQuestion(
                                      question: q['question'],
                                      options: List<String>.from(q['options']),
                                      correctAnswerIndex:
                                          q['correctAnswerIndex'],
                                    );
                                  }).toList();
                                }

                                return Subtopic(
                                  name: subtopicMap['name'],
                                  description: subtopicMap['description'],
                                  tutorialLink: subtopicMap['tutorialLink'],
                                  quizQuestions: subtopicQuizQuestions,
                                );
                              }).toList();
                            }

                            return Topic(
                              name: topicMap['name'],
                              description: topicMap['description'],
                              tutorialLink: topicMap['tutorialLink'],
                              quizQuestions: quizQuestions,
                              subtopics: subtopics, // Add subtopics
                            );
                          }).toList();
                        } else {
                          // Fallback for courses with simple topic names
                          final simpleTopics = topicData as List<String>;
                          topics = simpleTopics
                              .map(
                                (name) => Topic(
                                  name: name,
                                  description:
                                      'Learn about $name in $courseName',
                                  tutorialLink:
                                      'https://example.com/$courseName/$name',
                                  quizQuestions: [
                                    QuizQuestion(
                                      question: 'What is $name?',
                                      options: [
                                        'A concept',
                                        'A technology',
                                        'A framework',
                                        'All of the above',
                                      ],
                                      correctAnswerIndex: 3,
                                    ),
                                    // Add more default questions as needed
                                  ],
                                  subtopics:
                                      [], // No subtopics for simple topics
                                ),
                              )
                              .toList();
                        }
                      }

                      final course = Course(
                        name: courseName,
                        description: courseDescription,
                        topics: topics,
                        icon: _getIconForCourse(courseName),
                      );

                      // Add course to enrolled courses
                      courseController.enrollCourse(course);

                      // Show success message
                      // According to requirements, don't navigate automatically
                      // Just show a snackbar and let user navigate manually
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '$courseName has been added to your courses!',
                          ),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );

                      // Don't navigate automatically - user should go to "My Course" manually
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: AppColor.lightPrimary.withAlpha(150))
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 1,
                  ),
                  child: const Text('Enroll Now', style: TextStyle(fontSize: 20)),
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
