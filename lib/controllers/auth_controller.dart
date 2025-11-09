import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:skillorbit/services/firestore_user_service.dart';
import 'package:skillorbit/controllers/course_controller.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreUserService _userService = FirestoreUserService();

  // Observable variables for UI
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhotoUrl = ''.obs;

  // User data
  User? get currentUser => _auth.currentUser;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes naturally
    _auth.authStateChanges().listen((User? user) {
      isLoggedIn.value = user != null;
      if (user != null) {
        userName.value = user.displayName ?? '';
        userEmail.value = user.email ?? '';
        userPhotoUrl.value = user.photoURL ?? '';
        // Update last login timestamp
        _userService.updateUserLastLogin(user.uid).catchError((error) {
          print('Failed to update last login timestamp: $error');
        });
        // Load user data when user logs in
        _loadUserData();
      } else {
        userName.value = '';
        userEmail.value = '';
        userPhotoUrl.value = '';
        // Clear user data when user logs out
        _clearUserData();
      }
      print('Auth state changed: ${user?.uid ?? "null"}');
    });
  }

  /// Load user data when user logs in
  Future<void> _loadUserData() async {
    try {
      final courseController = Get.find<CourseController>();
      await courseController.loadUserData();
      print('User data loaded successfully');
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  /// Clear user data when user logs out
  void _clearUserData() {
    try {
      final courseController = Get.find<CourseController>();
      courseController.clearUserData();
      print('User data cleared successfully');
    } catch (e) {
      print('Error clearing user data: $e');
    }
  }

  /// Sign up with email, password, username and photo URL
  Future<String?> signUpWithEmail(
    String email,
    String password,
    String username,
    String photoUrl,
  ) async {
    try {
      isLoading.value = true;
      print('Attempting to create user with email: $email');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update user profile with username and photo
      await userCredential.user?.updateDisplayName(username);
      await userCredential.user?.updatePhotoURL(photoUrl);
      await userCredential.user?.reload();

      // Create user document in Firestore
      try {
        await _userService.createUserDocument(
          userCredential.user!.uid,
          email,
          username,
          photoUrl,
        );
      } catch (e) {
        print('Warning: Failed to create user document in Firestore: $e');
        // Even if Firestore creation fails, we still want to allow the user to sign up
        // The document will be created when they first try to enroll in a course
      }

      // Update observable values
      userName.value = username;
      userPhotoUrl.value = photoUrl;

      isLoading.value = false;
      print('User created successfully with UID: ${userCredential.user?.uid}');
      return null; // Return null on success
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print('FirebaseAuthException during signup: ${e.code} - ${e.message}');
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else if (e.code == 'operation-not-allowed') {
        return 'Email/password accounts are not enabled. Please contact the app administrator.';
      } else if (e.code == 'configuration-not-found' ||
          e.message?.contains('configuration not found') == true) {
        return 'Firebase Authentication is not properly configured. Please contact the app administrator.';
      } else {
        return e.message ?? 'An authentication error occurred.';
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      print('Unexpected error during signup: $e');
      print('Stack trace: $stackTrace');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Login with email and password
  Future<String?> loginWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      print('Attempting to sign in with email: $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;
      print(
        'User signed in successfully with UID: ${userCredential.user?.uid}',
      );
      return null; // Return null on success
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print('FirebaseAuthException during login: ${e.code} - ${e.message}');
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else if (e.code == 'user-disabled') {
        return 'This user account has been disabled.';
      } else if (e.code == 'configuration-not-found' ||
          e.message?.contains('configuration not found') == true) {
        return 'Firebase Authentication is not properly configured. Please contact the app administrator.';
      } else {
        return e.message ?? 'An authentication error occurred.';
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      print('Unexpected error during login: $e');
      print('Stack trace: $stackTrace');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Upload image to Firebase Storage and return download URL
  Future<String?> _uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child(
            '${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}',
          );

      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  /// Update user profile (username and photo)
  Future<String?> updateProfile(
    String username,
    String photoUrl, {
    File? imageFile,
  }) async {
    try {
      isLoading.value = true;
      User? user = _auth.currentUser;

      if (user == null) {
        isLoading.value = false;
        return 'No user logged in';
      }

      String? photoUrlToUse = photoUrl;

      // If a new image file is provided, upload it first
      if (imageFile != null) {
        final downloadUrl = await _uploadImage(imageFile);
        if (downloadUrl == null) {
          isLoading.value = false;
          return 'Failed to upload profile picture';
        }
        photoUrlToUse = downloadUrl;
      }

      // Only update display name if it has changed
      if (user.displayName != username) {
        await user.updateDisplayName(username);
      }

      // Only update photo URL if it has changed
      if (user.photoURL != photoUrlToUse) {
        await user.updatePhotoURL(photoUrlToUse);
      }

      await user.reload();

      // Update observable values
      userName.value = username;
      userPhotoUrl.value = photoUrlToUse ?? '';

      isLoading.value = false;
      return null; // Success
    } catch (e) {
      isLoading.value = false;
      print('Error updating profile: $e');
      return 'Failed to update profile: $e';
    }
  }

  /// Change password
  Future<String?> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      isLoading.value = true;
      User? user = _auth.currentUser;

      if (user == null || user.email == null) {
        isLoading.value = false;
        return 'No user logged in';
      }

      // Re-authenticate user before changing password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      isLoading.value = false;
      return null; // Success
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'wrong-password') {
        return 'Current password is incorrect';
      } else if (e.code == 'weak-password') {
        return 'New password is too weak';
      } else {
        return e.message ?? 'Failed to change password';
      }
    } catch (e) {
      isLoading.value = false;
      print('Error changing password: $e');
      return 'Failed to change password: $e';
    }
  }

  /// Send password reset email
  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);
      isLoading.value = false;
      return null; // Success
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        return 'No user found with this email address';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email address';
      } else {
        return e.message ?? 'Failed to send password reset email';
      }
    } catch (e) {
      isLoading.value = false;
      print('Error sending password reset email: $e');
      return 'An unexpected error occurred';
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
