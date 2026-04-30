import 'package:cloud_firestore/cloud_firestore.dart';

/// Service class for interacting with Firestore database
///
/// This service provides methods to fetch course data from Firestore,
/// following the repository pattern.
///
/// The service now uses a FLAT structure for better performance and admin control:
/// courses (top-level)
/// modules (top-level, linked by courseId)
/// topics (top-level, linked by moduleId)
/// quizzes (top-level, linked by parentId)
class FirestoreCourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Courses ---

  /// Gets all courses ordered by name
  Stream<QuerySnapshot> getAllCourses() {
    print('Fetching all courses from Firestore (Flat)');
    return _firestore.collection('courses').orderBy('name').snapshots();
  }

  /// Gets a specific course by ID
  Future<DocumentSnapshot> getCourse(String courseId) {
    return _firestore.collection('courses').doc(courseId).get();
  }

  // --- Modules (Formerly Topics) ---

  /// Gets all modules for a specific course
  Stream<QuerySnapshot> getCourseModules(String courseId) {
    print('Fetching modules for course ID: $courseId');
    return _firestore
        .collection('modules')
        .where('courseId', isEqualTo: courseId)
        .snapshots();
  }

  // --- Topics (Formerly Subtopics) ---

  /// Gets all topics for a specific module
  Stream<QuerySnapshot> getModuleTopics(String moduleId) {
    print('Fetching topics for module ID: $moduleId');
    return _firestore
        .collection('topics')
        .where('moduleId', isEqualTo: moduleId)
        .snapshots();
  }

  // --- Quizzes ---

  /// Gets quiz questions for a module or topic
  Stream<QuerySnapshot> getQuizQuestions(String parentId) {
    print('Fetching quiz questions for parent ID: $parentId');
    return _firestore
        .collection('quizzes')
        .where('parentId', isEqualTo: parentId)
        .snapshots();
  }

  // --- CRUD Operations (Admin) ---

  // Courses
  Future<void> addCourse(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    // Use the name as the document ID for easier management
    return _firestore.collection('courses').doc(name).set(data);
  }

  Future<void> updateCourse(String id, Map<String, dynamic> data) {
    return _firestore.collection('courses').doc(id).update(data);
  }

  Future<void> deleteCourse(String id) {
    return _firestore.collection('courses').doc(id).delete();
  }

  // Modules
  Future<void> addModule(Map<String, dynamic> data) {
    final String courseId = data['courseId'] as String;
    final String name = data['name'] as String;
    final String id = '${courseId}_$name';
    return _firestore.collection('modules').doc(id).set(data);
  }

  Future<void> updateModule(String id, Map<String, dynamic> data) {
    return _firestore.collection('modules').doc(id).update(data);
  }

  Future<void> deleteModule(String id) {
    return _firestore.collection('modules').doc(id).delete();
  }

  // Topics
  Future<void> addTopic(Map<String, dynamic> data) {
    final String moduleId = data['moduleId'] as String;
    final String name = data['name'] as String;
    final String id = '${moduleId}_$name';
    return _firestore.collection('topics').doc(id).set(data);
  }

  Future<void> updateTopic(String id, Map<String, dynamic> data) {
    return _firestore.collection('topics').doc(id).update(data);
  }

  Future<void> deleteTopic(String id) {
    return _firestore.collection('topics').doc(id).delete();
  }

  // Quizzes
  Future<void> addQuizQuestion(Map<String, dynamic> data) {
    return _firestore.collection('quizzes').add(data);
  }

  Future<void> updateQuizQuestion(String id, Map<String, dynamic> data) {
    return _firestore.collection('quizzes').doc(id).update(data);
  }

  Future<void> deleteQuizQuestion(String id) {
    return _firestore.collection('quizzes').doc(id).delete();
  }

  // --- Legacy Support & Simple Courses ---

  /// Gets simple topic names for courses without detailed structure
  Future<List<String>> getSimpleCourseTopics(String courseId) async {
    final courseDoc = await getCourse(courseId);
    final data = courseDoc.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('topicNames')) {
      return List<String>.from(data['topicNames'] as List);
    }
    return [];
  }
}
