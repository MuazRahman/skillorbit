import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a course in the learning platform
///
/// A course contains topics that users can study. Courses can have either
/// detailed topics with subtopics and quizzes, or simple topic lists.
class Course {
  /// Unique identifier for the course
  final String id;

  /// Name of the course (e.g., "Flutter", "Java")
  final String name;

  /// Description of what the course covers
  final String description;

  /// Flag indicating if this course has detailed topics structure
  /// If true, the course has topics with subtopics and quizzes
  /// If false, the course only has a simple list of topic names
  final bool hasDetailedTopics;

  /// List of topic names for courses without detailed structure
  /// Used for simple courses that don't have subtopics
  final List<String> topicNames;

  /// List of detailed topics for courses with complex structure
  /// Each topic can contain subtopics and quizzes
  final List<Topic> topics;

  /// Icon path or identifier for the course
  final String icon;

  /// Creates a new Course instance
  ///
  /// [id] - Unique identifier for the course
  /// [name] - Name of the course
  /// [description] - Description of the course content
  /// [hasDetailedTopics] - Whether the course has detailed topic structure
  /// [topicNames] - List of topic names for simple courses (default: empty list)
  /// [topics] - List of detailed topics for complex courses (default: empty list)
  /// [icon] - Icon identifier for the course
  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.hasDetailedTopics,
    this.topicNames = const [],
    this.topics = const [],
    required this.icon,
  });

  /// Creates a Course instance from Firestore document data
  ///
  /// This factory constructor extracts data from a Firestore DocumentSnapshot
  /// and creates a Course object. Note that topics and icon are not populated
  /// here and should be set separately.
  ///
  /// [doc] - Firestore document containing course data
  factory Course.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Course(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      hasDetailedTopics: data['hasDetailedTopics'] ?? false,
      topicNames: data['topicNames'] != null
          ? List<String>.from(data['topicNames'])
          : const [],
      topics: const [], // This will be populated separately
      icon: '', // This will be set separately
    );
  }
}

/// Represents a topic within a course
///
/// Topics are the main subjects within a course. They can contain
/// subtopics and quizzes to help users learn the material.
class Topic {
  /// Unique identifier for the topic
  final String id;

  /// Name of the topic (e.g., "Widgets", "State Management")
  final String name;

  /// Description of what the topic covers
  final String description;

  /// Link to tutorial or additional learning resources
  final String tutorialLink;

  /// Order of the topic within the course
  final int order;

  /// List of quiz questions related to this topic
  final List<QuizQuestion> quizQuestions;

  /// List of subtopics within this topic
  final List<Subtopic> subtopics;

  /// Flag indicating if the user has completed this topic
  final bool isCompleted;

  /// Creates a new Topic instance
  ///
  /// [id] - Unique identifier for the topic
  /// [name] - Name of the topic
  /// [description] - Description of the topic content
  /// [tutorialLink] - Link to tutorial resources
  /// [order] - Position of the topic in the course
  /// [quizQuestions] - List of quiz questions (default: empty list)
  /// [subtopics] - List of subtopics (default: empty list)
  /// [isCompleted] - Completion status (default: false)
  Topic({
    required this.id,
    required this.name,
    required this.description,
    required this.tutorialLink,
    required this.order,
    this.quizQuestions = const [],
    this.subtopics = const [],
    this.isCompleted = false,
  });

  /// Creates a Topic instance from Firestore document data
  ///
  /// This factory constructor extracts data from a Firestore DocumentSnapshot
  /// and creates a Topic object. Note that quizQuestions, subtopics, and
  /// isCompleted are not populated here and should be set separately.
  ///
  /// [doc] - Firestore document containing topic data
  factory Topic.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Topic(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      tutorialLink: data['tutorialLink'] ?? '',
      order: data['order'] ?? 0,
      quizQuestions: const [],
      subtopics: const [],
      isCompleted: false,
    );
  }
}

/// Represents a subtopic within a topic
///
/// Subtopics are more granular subjects within a topic. They help
/// break down complex topics into manageable learning units.
class Subtopic {
  /// Unique identifier for the subtopic
  final String id;

  /// Name of the subtopic (e.g., "Container Widget", "Text Widget")
  final String name;

  /// Description of what the subtopic covers
  final String description;

  /// Link to tutorial or additional learning resources
  final String tutorialLink;

  /// Order of the subtopic within the topic
  final int order;

  /// List of quiz questions related to this subtopic
  final List<QuizQuestion> quizQuestions;

  /// Creates a new Subtopic instance
  ///
  /// [id] - Unique identifier for the subtopic
  /// [name] - Name of the subtopic
  /// [description] - Description of the subtopic content
  /// [tutorialLink] - Link to tutorial resources
  /// [order] - Position of the subtopic in the topic
  /// [quizQuestions] - List of quiz questions (default: empty list)
  Subtopic({
    required this.id,
    required this.name,
    required this.description,
    required this.tutorialLink,
    required this.order,
    this.quizQuestions = const [],
  });

  /// Creates a Subtopic instance from Firestore document data
  ///
  /// This factory constructor extracts data from a Firestore DocumentSnapshot
  /// and creates a Subtopic object. Note that quizQuestions is not populated
  /// here and should be set separately.
  ///
  /// [doc] - Firestore document containing subtopic data
  factory Subtopic.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Subtopic(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      tutorialLink: data['tutorialLink'] ?? '',
      order: data['order'] ?? 0,
      quizQuestions: const [],
    );
  }
}

/// Represents a quiz question
///
/// Quiz questions are used to test user knowledge of topics and subtopics.
/// Each question has multiple options with one correct answer.
class QuizQuestion {
  /// Unique identifier for the question
  final String id;

  /// The question text
  final String question;

  /// List of possible answer options
  final List<String> options;

  /// Index of the correct answer in the options list (0-based)
  final int correctAnswerIndex;

  /// Order of the question within the quiz
  final int order;

  /// Creates a new QuizQuestion instance
  ///
  /// [id] - Unique identifier for the question
  /// [question] - The question text
  /// [options] - List of possible answers
  /// [correctAnswerIndex] - Index of the correct answer (0-based)
  /// [order] - Position of the question in the quiz
  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.order,
  });

  /// Creates a QuizQuestion instance from Firestore document data
  ///
  /// This factory constructor extracts data from a Firestore DocumentSnapshot
  /// and creates a QuizQuestion object.
  ///
  /// [doc] - Firestore document containing question data
  factory QuizQuestion.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return QuizQuestion(
      id: doc.id,
      question: data['question'] ?? '',
      options: data['options'] != null
          ? List<String>.from(data['options'])
          : [],
      correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
      order: data['order'] ?? 0,
    );
  }
}

/// Represents a user achievement
///
/// Achievements are awarded when users complete topics or subtopics.
/// They track user progress and accomplishments.
class Achievement {
  /// Name of the topic or subtopic that was completed
  final String topicName;

  /// Name of the course containing the completed topic
  final String courseName;

  /// Date when the achievement was earned
  final DateTime dateCompleted;

  /// Creates a new Achievement instance
  ///
  /// [topicName] - Name of the completed topic/subtopic
  /// [courseName] - Name of the course
  /// [dateCompleted] - Date when the achievement was earned
  Achievement({
    required this.topicName,
    required this.courseName,
    required this.dateCompleted,
  });
}
