import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillorbit/controllers/auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  final ImagePicker _imagePicker = ImagePicker();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isChangingPassword = false;
  File? _selectedImage;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    // Pre-fill with current user data
    _usernameController.text = _authController.userName.value;
    _profilePictureController.text = _authController.userPhotoUrl.value;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _profilePictureController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image != null) {
        final imageFile = File(image.path);
        setState(() {
          _selectedImage = imageFile;
        });

        // Convert to base64 for storage in Firestore
        try {
          final bytes = await imageFile.readAsBytes();
          final extension = image.path.split('.').last.toLowerCase();
          String mimeType = 'image/jpeg'; // default
          if (extension == 'png') {
            mimeType = 'image/png';
          } else if (extension == 'gif') {
            mimeType = 'image/gif';
          } else if (extension == 'webp') {
            mimeType = 'image/webp';
          }
          _base64Image = 'data:$mimeType;base64,${base64Encode(bytes)}';
          _profilePictureController.text = _base64Image!;
        } catch (e) {
          print('Error encoding image to base64: $e');
        }

        Get.snackbar(
          'Success',
          'Profile picture selected! Click save to update your profile.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _handleUpdateProfile() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final currentPhotoUrl = _authController.userPhotoUrl.value;

      final result = await _authController.updateProfile(
        username,
        currentPhotoUrl,
        imageFile: _selectedImage,
      );

      if (result == null) {
        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back(); // Go back to profile screen
      } else {
        Get.snackbar(
          'Error',
          result,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> _handleChangePassword() async {
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all password fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'New passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_newPasswordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final result = await _authController.changePassword(
      _currentPasswordController.text,
      _newPasswordController.text,
    );

    if (result == null) {
      Get.snackbar(
        'Success',
        'Password changed successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Clear password fields
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      setState(() {
        _isChangingPassword = false;
      });
    } else {
      Get.snackbar(
        'Error',
        result,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Preview
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _selectedImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_selectedImage!),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            )
                          : Obx(() {
                              final photoUrl = _profilePictureController.text.isNotEmpty
                                  ? _profilePictureController.text
                                  : _authController.userPhotoUrl.value;
                              
                              if (photoUrl.isEmpty) {
                                return CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                                );
                              }
                              
                              // Check if it's a base64 image
                              if (photoUrl.startsWith('data:image')) {
                                try {
                                  final base64String = photoUrl.split(',')[1];
                                  final bytes = base64Decode(base64String);
                                  return CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    backgroundImage: MemoryImage(bytes),
                                  );
                                } catch (e) {
                                  return CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: const Icon(Icons.person, size: 60, color: Colors.white),
                                  );
                                }
                              }
                              
                              // Otherwise, it's a network URL
                              return CircleAvatar(
                                radius: 60,
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                backgroundImage: NetworkImage(photoUrl),
                                onBackgroundImageError: (_, __) {},
                              );
                            }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Pick Image Button
                Center(
                  child: TextButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Change Profile Picture'),
                  ),
                ),
                const SizedBox(height: 24),

                // Username Field
                Text(
                  'Username',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Update Profile Button
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _authController.isLoading.value
                          ? null
                          : _handleUpdateProfile,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _authController.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Update Profile',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  );
                }),
                const SizedBox(height: 32),

                // Change Password Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: _isChangingPassword,
                      onChanged: (value) {
                        setState(() {
                          _isChangingPassword = value;
                          if (!value) {
                            _currentPasswordController.clear();
                            _newPasswordController.clear();
                            _confirmPasswordController.clear();
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                if (_isChangingPassword) ...[
                  // Current Password
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: _obscureCurrentPassword,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureCurrentPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureCurrentPassword = !_obscureCurrentPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // New Password
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _obscureNewPassword,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Confirm New Password
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Change Password Button
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _authController.isLoading.value
                            ? null
                            : _handleChangePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _authController.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Change Password',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    );
                  }),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
