import 'package:cloud_firestore/cloud_firestore.dart';

/// Service class for interacting with Firestore database
///
/// This service provides methods to fetch course data from Firestore,
/// following the repository pattern to separate data access logic
/// from business logic and UI concerns.
///
/// The service handles the hierarchical structure of course data:
/// courses → topics → subtopics → quizQuestions
class FirestoreCourseService {
  /// Firestore instance for database operations
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Gets a stream of all courses
  ///
  /// Returns a stream that emits snapshots of all courses in the database,
  /// ordered by course name. The stream automatically updates when
  /// courses are added, modified, or removed.
  Stream<QuerySnapshot> getAllCourses() {
    print('Fetching all courses from Firestore');
    return _firestore.collection('courses').orderBy('name').snapshots();
  }

  /// Gets a specific course by ID
  ///
  /// Fetches a single course document from Firestore by its document ID.
  ///
  /// [courseId] - The ID of the course to fetch
  Future<DocumentSnapshot> getCourse(String courseId) {
    print('Fetching course with ID: $courseId');
    return _firestore.collection('courses').doc(courseId).get();
  }

  /// Gets a stream of topics for a specific course
  ///
  /// Returns a stream that emits snapshots of all topics for the specified course,
  /// ordered by topic order. The stream automatically updates when topics
  /// are added, modified, or removed.
  ///
  /// [courseId] - The ID of the course to get topics for
  Stream<QuerySnapshot> getCourseTopics(String courseId) {
    print('Fetching topics for course ID: $courseId');
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('topics')
        .orderBy('order')
        .snapshots();
  }

  /// Gets a specific topic by ID
  ///
  /// Fetches a single topic document from Firestore by its document ID
  /// within the specified course.
  ///
  /// [courseId] - The ID of the course containing the topic
  /// [topicId] - The ID of the topic to fetch
  Future<DocumentSnapshot> getTopic(String courseId, String topicId) {
    print('Fetching topic with ID: $topicId for course ID: $courseId');
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('topics')
        .doc(topicId)
        .get();
  }

  /// Gets a stream of subtopics for a specific topic
  ///
  /// Returns a stream that emits snapshots of all subtopics for the specified topic,
  /// ordered by subtopic order. The stream automatically updates when subtopics
  /// are added, modified, or removed.
  ///
  /// [courseId] - The ID of the course containing the topic
  /// [topicId] - The ID of the topic to get subtopics for
  Stream<QuerySnapshot> getSubtopics(String courseId, String topicId) {
    print('Fetching subtopics for course ID: $courseId, topic ID: $topicId');
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('topics')
        .doc(topicId)
        .collection('subtopics')
        .orderBy('order')
        .snapshots();
  }

  /// Gets a specific subtopic by ID
  ///
  /// Fetches a single subtopic document from Firestore by its document ID
  /// within the specified topic.
  ///
  /// [courseId] - The ID of the course containing the subtopic
  /// [topicId] - The ID of the topic containing the subtopic
  /// [subtopicId] - The ID of the subtopic to fetch
  Future<DocumentSnapshot> getSubtopic(
    String courseId,
    String topicId,
    String subtopicId,
  ) {
    print(
      'Fetching subtopic with ID: $subtopicId for course ID: $courseId, topic ID: $topicId',
    );
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('topics')
        .doc(topicId)
        .collection('subtopics')
        .doc(subtopicId)
        .get();
  }

  /// Gets a stream of quiz questions for a specific subtopic
  ///
  /// Returns a stream that emits snapshots of all quiz questions for the specified subtopic,
  /// ordered by question order. The stream automatically updates when questions
  /// are added, modified, or removed.
  ///
  /// [courseId] - The ID of the course containing the subtopic
  /// [topicId] - The ID of the topic containing the subtopic
  /// [subtopicId] - The ID of the subtopic to get quiz questions for
  Stream<QuerySnapshot> getSubtopicQuizQuestions(
    String courseId,
    String topicId,
    String subtopicId,
  ) {
    print(
      'Fetching quiz questions for subtopic ID: $subtopicId, course ID: $courseId, topic ID: $topicId',
    );
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('topics')
        .doc(topicId)
        .collection('subtopics')
        .doc(subtopicId)
        .collection('quizQuestions')
        .orderBy('order')
        .snapshots();
  }

  /// Gets a stream of quiz questions for a specific topic
  ///
  /// Returns a stream that emits snapshots of all quiz questions for the specified topic,
  /// ordered by question order. The stream automatically updates when questions
  /// are added, modified, or removed.
  ///
  /// [courseId] - The ID of the course containing the topic
  /// [topicId] - The ID of the topic to get quiz questions for
  Stream<QuerySnapshot> getTopicQuizQuestions(String courseId, String topicId) {
    print(
      'Fetching quiz questions for topic ID: $topicId, course ID: $courseId',
    );
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('topics')
        .doc(topicId)
        .collection('quizQuestions')
        .orderBy('order')
        .snapshots();
  }

  /// Gets simple topic names for courses without detailed structure
  ///
  /// Fetches the list of topic names for courses that don't have
  /// detailed topic/subtopic structure. These courses store topic
  /// names as a simple array in the course document.
  ///
  /// [courseId] - The ID of the course to get topic names for
  Future<List<String>> getSimpleCourseTopics(String courseId) async {
    print('Fetching simple course topics for course ID: $courseId');
    final courseDoc = await _firestore
        .collection('courses')
        .doc(courseId)
        .get();
    final data = courseDoc.data();
    print('Course document data: $data');

    if (data != null && data.containsKey('topicNames')) {
      print(
        'Found ${data['topicNames'].length} simple topics for course ID: $courseId',
      );
      return List<String>.from(data['topicNames'] as List);
    }

    print('No simple topics found for course ID: $courseId');
    return [];
  }
}
