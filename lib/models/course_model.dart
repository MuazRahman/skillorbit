import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a course in the learning platform
class Course {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool hasDetailedTopics;
  final List<String> topicNames; // Legacy support
  final String icon; // Asset path for local icons

  Course({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl = '',
    this.hasDetailedTopics = true,
    this.topicNames = const [],
    required this.icon,
  });

  factory Course.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Course(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      hasDetailedTopics: data['hasDetailedTopics'] ?? true,
      topicNames: data['topicNames'] != null ? List<String>.from(data['topicNames']) : const [],
      icon: data['icon'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'hasDetailedTopics': hasDetailedTopics,
      'topicNames': topicNames,
      'icon': icon,
    };
  }
}

/// Represents a Module within a Course (formerly Topic)
class Module {
  final String id;
  final String courseId;
  final String name;
  final String description;
  final int order;

  Module({
    required this.id,
    required this.courseId,
    required this.name,
    required this.description,
    required this.order,
  });

  factory Module.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Module(
      id: doc.id,
      courseId: data['courseId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'courseId': courseId,
      'name': name,
      'description': description,
      'order': order,
    };
  }
}

/// Represents a Topic within a Module (formerly Subtopic)
class Topic {
  final String id;
  final String moduleId;
  final String courseId;
  final String name;
  final String description;
  final String tutorialLink; // "topic doc"
  final String videoUrl; // "youtube video"
  final int order;

  Topic({
    required this.id,
    required this.moduleId,
    required this.courseId,
    required this.name,
    required this.description,
    required this.tutorialLink,
    required this.videoUrl,
    required this.order,
  });

  factory Topic.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Topic(
      id: doc.id,
      moduleId: data['moduleId'] ?? '',
      courseId: data['courseId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      tutorialLink: data['tutorialLink'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'moduleId': moduleId,
      'courseId': courseId,
      'name': name,
      'description': description,
      'tutorialLink': tutorialLink,
      'videoUrl': videoUrl,
      'order': order,
    };
  }
}

/// Represents a quiz question
class QuizQuestion {
  final String id;
  final String parentId; // Can be moduleId or topicId
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int order;

  QuizQuestion({
    required this.id,
    required this.parentId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.order,
  });

  factory QuizQuestion.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return QuizQuestion(
      id: doc.id,
      parentId: data['parentId'] ?? '',
      question: data['question'] ?? '',
      options: data['options'] != null ? List<String>.from(data['options']) : [],
      correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'parentId': parentId,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'order': order,
    };
  }
}

/// Represents a user achievement
class Achievement {
  final String topicName;
  final String courseName;
  final DateTime dateCompleted;

  Achievement({
    required this.topicName,
    required this.courseName,
    required this.dateCompleted,
  });

  factory Achievement.fromMap(Map<String, dynamic> data) {
    return Achievement(
      topicName: data['topicName'] ?? '',
      courseName: data['courseName'] ?? '',
      dateCompleted: (data['dateCompleted'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topicName': topicName,
      'courseName': courseName,
      'dateCompleted': Timestamp.fromDate(dateCompleted),
    };
  }
}
