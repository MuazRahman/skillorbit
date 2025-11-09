import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skillorbit/models/course_model.dart';

/// Service class for interacting with Firestore user data
///
/// This service provides methods to manage user data in Firestore,
/// including creating user documents, enrolling in courses, and retrieving
/// user-specific data.
class FirestoreUserService {
  /// Firestore instance for database operations
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Auth instance for getting current user
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Creates a new user document in Firestore when a user signs up
  ///
  /// This method should be called after a successful signup to create
  /// a user document in the 'users' collection.
  ///
  /// [uid] - The Firebase UID of the user
  /// [email] - The email of the user
  /// [username] - The username/display name of the user
  /// [photoUrl] - The profile photo URL of the user (optional)
  Future<void> createUserDocument(
    String uid,
    String email,
    String username,
    String? photoUrl,
  ) async {
    try {
      print('Creating user document for UID: $uid');

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'username': username,
        'photoUrl': photoUrl ?? '',
        'enrolledCourses': [],
        'achievements': [],
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
      });

      print('User document created successfully for UID: $uid');
    } catch (e) {
      print('Error creating user document for UID $uid: $e');
      rethrow;
    }
  }

  /// Ensures a user document exists, creating it if necessary
  ///
  /// This method checks if a user document exists and creates it if it doesn't.
  /// This is useful for cases where we need to ensure the document exists before
  /// performing operations on it.
  ///
  /// [uid] - The Firebase UID of the user
  /// [email] - The email of the user (optional, used when creating document)
  /// [username] - The username/display name of the user (optional, used when creating document)
  /// [photoUrl] - The profile photo URL of the user (optional)
  Future<void> ensureUserDocumentExists(
    String uid, {
    String? email,
    String? username,
    String? photoUrl,
  }) async {
    try {
      print('Ensuring user document exists for UID: $uid');

      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        print('User document does not exist for UID: $uid, creating it now');
        // Create the document with default values if email/username are not provided
        await _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': email ?? '',
          'username': username ?? 'User',
          'photoUrl': photoUrl ?? '',
          'enrolledCourses': [],
          'achievements': [],
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
        });
        print('User document created successfully for UID: $uid');
      } else {
        print('User document already exists for UID: $uid');
      }
    } catch (e) {
      print('Error ensuring user document exists for UID $uid: $e');
      rethrow;
    }
  }

  /// Enrolls a user in a course
  ///
  /// Adds a course name to the user's enrolledCourses array in Firestore.
  /// If the user document doesn't exist, it will be created first.
  ///
  /// [uid] - The Firebase UID of the user
  /// [courseName] - The name of the course to enroll in
  Future<void> enrollUserInCourse(String uid, String courseName) async {
    try {
      print('Enrolling user $uid in course: $courseName');

      // Ensure the user document exists before trying to update it
      await ensureUserDocumentExists(uid);

      await _firestore.collection('users').doc(uid).update({
        'enrolledCourses': FieldValue.arrayUnion([courseName]),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('User $uid successfully enrolled in course: $courseName');
    } catch (e) {
      print('Error enrolling user $uid in course $courseName: $e');
      rethrow;
    }
  }

  /// Removes a course from a user's enrolled courses
  ///
  /// Removes a course name from the user's enrolledCourses array in Firestore.
  ///
  /// [uid] - The Firebase UID of the user
  /// [courseName] - The name of the course to remove
  Future<void> removeUserFromCourse(String uid, String courseName) async {
    try {
      print('Removing user $uid from course: $courseName');

      await _firestore.collection('users').doc(uid).update({
        'enrolledCourses': FieldValue.arrayRemove([courseName]),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('User $uid successfully removed from course: $courseName');
    } catch (e) {
      print('Error removing user $uid from course $courseName: $e');
      rethrow;
    }
  }

  /// Gets a user's enrolled courses
  ///
  /// Retrieves the list of course names that a user is enrolled in.
  ///
  /// [uid] - The Firebase UID of the user
  Future<List<String>> getUserEnrolledCourses(String uid) async {
    try {
      print('Fetching enrolled courses for user: $uid');

      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        if (data.containsKey('enrolledCourses')) {
          final courses = List<String>.from(data['enrolledCourses']);
          print('Found ${courses.length} enrolled courses for user $uid');
          return courses;
        }
      }

      print('No enrolled courses found for user $uid');
      return [];
    } catch (e) {
      print('Error fetching enrolled courses for user $uid: $e');
      return [];
    }
  }

  /// Adds an achievement to a user's achievements list
  ///
  /// Adds a new achievement to the user's achievements array in Firestore.
  /// If the user document doesn't exist, it will be created first.
  ///
  /// [uid] - The Firebase UID of the user
  /// [achievement] - The achievement to add
  Future<void> addUserAchievement(String uid, Achievement achievement) async {
    try {
      print('Adding achievement for user $uid: ${achievement.topicName}');

      // Ensure the user document exists before trying to update it
      await ensureUserDocumentExists(uid);

      // Convert achievement to a map
      final achievementMap = {
        'topicName': achievement.topicName,
        'courseName': achievement.courseName,
        'dateCompleted': achievement.dateCompleted,
      };

      await _firestore.collection('users').doc(uid).update({
        'achievements': FieldValue.arrayUnion([achievementMap]),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print(
        'Achievement added successfully for user $uid: ${achievement.topicName}',
      );
    } catch (e) {
      print('Error adding achievement for user $uid: $e');
      rethrow;
    }
  }

  /// Removes all achievements for a specific course
  ///
  /// Removes all achievements associated with a specific course from the user's achievements array in Firestore.
  ///
  /// [uid] - The Firebase UID of the user
  /// [courseName] - The name of the course whose achievements should be removed
  Future<void> removeUserAchievementsForCourse(
    String uid,
    String courseName,
  ) async {
    try {
      print('Removing achievements for user $uid in course: $courseName');

      // First, get the current achievements
      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        if (data.containsKey('achievements')) {
          final achievementsData = data['achievements'] as List;
          final achievements = <Map<String, dynamic>>[];

          // Filter out achievements for the specified course
          for (var achievementData in achievementsData) {
            if (achievementData is Map<String, dynamic>) {
              if (achievementData['courseName'] != courseName) {
                achievements.add(achievementData);
              }
            }
          }

          // Update the user document with the filtered achievements
          await _firestore.collection('users').doc(uid).update({
            'achievements': achievements,
            'updatedAt': FieldValue.serverTimestamp(),
          });

          print(
            'Successfully removed achievements for user $uid in course: $courseName',
          );
        }
      }
    } catch (e) {
      print(
        'Error removing achievements for user $uid in course $courseName: $e',
      );
      rethrow;
    }
  }

  /// Gets a user's achievements
  ///
  /// Retrieves the list of achievements for a user.
  ///
  /// [uid] - The Firebase UID of the user
  Future<List<Achievement>> getUserAchievements(String uid) async {
    try {
      print('Fetching achievements for user: $uid');

      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        if (data.containsKey('achievements')) {
          final achievementsData = data['achievements'] as List;
          final achievements = <Achievement>[];

          for (var achievementData in achievementsData) {
            if (achievementData is Map<String, dynamic>) {
              achievements.add(
                Achievement(
                  topicName: achievementData['topicName'] as String,
                  courseName: achievementData['courseName'] as String,
                  dateCompleted: (achievementData['dateCompleted'] as Timestamp)
                      .toDate(),
                ),
              );
            }
          }

          print('Found ${achievements.length} achievements for user $uid');
          return achievements;
        }
      }

      print('No achievements found for user $uid');
      return [];
    } catch (e) {
      print('Error fetching achievements for user $uid: $e');
      return [];
    }
  }

  /// Updates user's last login timestamp
  ///
  /// Updates the lastLoginAt field for a user document.
  /// If the user document doesn't exist, it will be created first.
  ///
  /// [uid] - The Firebase UID of the user
  Future<void> updateUserLastLogin(String uid) async {
    try {
      print('Updating last login for user: $uid');

      // Ensure the user document exists before trying to update it
      await ensureUserDocumentExists(uid);

      await _firestore.collection('users').doc(uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });

      print('Last login updated for user: $uid');
    } catch (e) {
      print('Error updating last login for user $uid: $e');
      rethrow;
    }
  }
}
