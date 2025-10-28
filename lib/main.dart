import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillorbit/core/app_theme.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'services/demo_course_details_json_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // Check if we need to migrate data
  await _migrateDataIfNeeded();

  // Firebase is initialized, app will fetch data from Firestore
  print('Firebase initialized. App will fetch data from Firestore.');

  AppTheme();
  runApp(App());
}

/// Migrates course data from local JSON to Firestore if needed
Future<void> _migrateDataIfNeeded() async {
  try {
    final firestore = FirebaseFirestore.instance;

    // Check if we have courses in Firestore
    final coursesSnapshot = await firestore.collection('courses').get();

    // If we have no courses in Firestore, migrate all data
    if (coursesSnapshot.size == 0) {
      print('No courses found in Firestore. Starting data migration...');
      await _migrateAllCourseData();
      print('Data migration completed successfully!');
    } else {
      print('Courses already exist in Firestore. Skipping migration.');
      // Check if we have sufficient courses
      final allCoursesSnapshot = await firestore.collection('courses').get();
      print('Total courses in Firestore: ${allCoursesSnapshot.size}');
    }
  } catch (e) {
    print('Error checking/migrating data: $e');
  }
}

/// Migrates all course data from local JSON to Firestore
Future<void> _migrateAllCourseData() async {
  final firestore = FirebaseFirestore.instance;
  final courseData = CourseDetailsJsonData().courseDetails;
  int courseCount = 0;

  try {
    // Process each course
    for (var entry in courseData.entries) {
      final courseName = entry.key;
      final courseDetails = entry.value;

      print('Processing course: $courseName');

      // Check if this is a course with detailed topics structure
      bool hasDetailedTopics = false;
      if (courseDetails.containsKey('topics') &&
          courseDetails['topics'] is List &&
          courseDetails['topics'].isNotEmpty) {
        // For courses with detailed topics (like Flutter)
        hasDetailedTopics = courseDetails['topics'][0] is Map;
      }

      // Create course document
      final courseDoc = await firestore.collection('courses').add({
        'name': courseName,
        'description': courseDetails['description'],
        'hasDetailedTopics': hasDetailedTopics,
        'createdAt': FieldValue.serverTimestamp(),
      });

      courseCount++;
      print('Added course: $courseName');

      // Check if this is a course with detailed topics structure
      if (courseDetails.containsKey('topics') &&
          courseDetails['topics'] is List &&
          courseDetails['topics'].isNotEmpty) {
        // For courses with detailed topics (like Flutter)
        if (courseDetails['topics'][0] is Map) {
          final topics = courseDetails['topics'] as List;

          print('  Course has ${topics.length} detailed topics');

          for (int i = 0; i < topics.length; i++) {
            var topic = topics[i];
            if (topic is Map) {
              // Add topic document
              final topicDoc = await courseDoc.collection('topics').add({
                'name': topic['name'],
                'description': topic['description'],
                'tutorialLink': topic['tutorialLink'],
                'order': i,
                'createdAt': FieldValue.serverTimestamp(),
              });

              print('    Added topic: ${topic['name']}');

              // Add subtopics if they exist
              if (topic['subtopics'] is List) {
                final subtopics = topic['subtopics'] as List;
                print('      Topic has ${subtopics.length} subtopics');

                for (int j = 0; j < subtopics.length; j++) {
                  var subtopic = subtopics[j];
                  if (subtopic is Map) {
                    final subtopicDoc = await topicDoc
                        .collection('subtopics')
                        .add({
                          'name': subtopic['name'],
                          'description': subtopic['description'],
                          'tutorialLink': subtopic['tutorialLink'],
                          'order': j,
                          'createdAt': FieldValue.serverTimestamp(),
                        });

                    print('        Added subtopic: ${subtopic['name']}');

                    // Add quiz questions for subtopic
                    if (subtopic['quizQuestions'] is List) {
                      final questions = subtopic['quizQuestions'] as List;
                      print(
                        '          Subtopic has ${questions.length} quiz questions',
                      );

                      for (int k = 0; k < questions.length; k++) {
                        var question = questions[k];
                        if (question is Map) {
                          await subtopicDoc.collection('quizQuestions').add({
                            'question': question['question'],
                            'options': question['options'],
                            'correctAnswerIndex':
                                question['correctAnswerIndex'],
                            'order': k,
                            'createdAt': FieldValue.serverTimestamp(),
                          });

                          print(
                            '            Added quiz question: ${question['question']}',
                          );
                        }
                      }
                    }
                  }
                }
              }

              // Add quiz questions for topic
              if (topic['quizQuestions'] is List) {
                final questions = topic['quizQuestions'] as List;
                print('      Topic has ${questions.length} quiz questions');

                for (int k = 0; k < questions.length; k++) {
                  var question = questions[k];
                  if (question is Map) {
                    await topicDoc.collection('quizQuestions').add({
                      'question': question['question'],
                      'options': question['options'],
                      'correctAnswerIndex': question['correctAnswerIndex'],
                      'order': k,
                      'createdAt': FieldValue.serverTimestamp(),
                    });

                    print(
                      '        Added quiz question: ${question['question']}',
                    );
                  }
                }
              }
            }
          }
        }
        // For courses with simple topic lists (like C, C++, etc.)
        else if (courseDetails['topics'][0] is String) {
          // Add topic names as an array in the course document
          await courseDoc.update({'topicNames': courseDetails['topics']});
          print('  Added simple topic names to course document');
        }
      }
    }

    print('Data migration completed successfully!');
    print('Summary:');
    print('- Courses added: $courseCount');
  } catch (e) {
    print('Error during data migration: $e');
    rethrow;
  }
}
