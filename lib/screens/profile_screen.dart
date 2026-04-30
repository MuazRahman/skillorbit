import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/controllers/auth_controller.dart';
import 'package:skillorbit/controllers/dashboard_controller.dart';
import 'package:skillorbit/models/course_model.dart';
import 'package:skillorbit/screens/edit_profile_screen.dart';
import 'package:skillorbit/screens/enhanced_achievements_screen.dart';
import 'package:skillorbit/screens/enrolled_course_screen.dart';
import 'package:skillorbit/widgets/top_round_corner_widget.dart';

class ProfileScreen extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();
  final AuthController authController = Get.find<AuthController>();
  final DashBoardController dashboardController =
      Get.find<DashBoardController>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load user data lazily after the build phase to avoid assertion errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });

    return TopRoundCornerScreen(
      child: RefreshIndicator(
        onRefresh: () async {
          // Refresh user data
          await courseController.loadUserData();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header with enhanced design
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
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(() {
                          final photoUrl = authController.userPhotoUrl.value;
                          if (photoUrl.isEmpty) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            );
                          }

                          // Check if it's a base64 image
                          if (photoUrl.startsWith('data:image')) {
                            try {
                              final base64String = photoUrl.split(',')[1];
                              final bytes = base64Decode(base64String);
                              return CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                backgroundImage: MemoryImage(bytes),
                              );
                            } catch (e) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              );
                            }
                          }

                          // Otherwise, it's a network URL
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: NetworkImage(photoUrl),
                            onBackgroundImageError: (_, __) {},
                          );
                        }),
                        GestureDetector(
                          onTap: () {
                            // Check if user is logged in before allowing edit
                            if (authController.isLoggedIn.value) {
                              // Navigate to edit profile screen
                              Get.to(() => const EditProfileScreen());
                            } else {
                              // Show snackbar to login with a login button
                              Get.snackbar(
                                'Login Required',
                                'Please login to edit your profile',
                                backgroundColor: Colors.amber,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                mainButton: TextButton(
                                  onPressed: () {
                                    Get.back(); // Close the snackbar
                                    Get.toNamed(
                                        '/login'); // Navigate to login screen
                                  },
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      final username = authController.userName.value;
                      return Text(
                        username.isNotEmpty ? username : 'Guest User',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Obx(() {
                      final email = authController.userEmail.value;
                      return Text(
                        email.isNotEmpty ? email : 'Not logged in',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Premium Member',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Enhanced Statistics Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Progress',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to My Course screen via bottom nav bar
                                dashboardController.currentPageIndex.value = 1;
                                // Pop to dashboard screen
                                Get.until((route) => route.isFirst);
                              },
                              child: _buildEnhancedStatCard(
                                context,
                                'Enrolled courses',
                                courseController.enrolledCourses.length
                                    .toString(),
                                Icons.school,
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to Enhanced Achievements screen
                                Get.to(() => EnhancedAchievementsScreen());
                              },
                              child: _buildEnhancedStatCard(
                                context,
                                'Achievements',
                                courseController.achievements.length.toString(),
                                Icons.emoji_events,
                                Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Courses Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Courses',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => Text(
                            '${courseController.enrolledCourses.length} enrolled',
                            style: const TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      if (courseController.enrolledCourses.isEmpty) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF64748B).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.book_outlined,
                                  size: 48,
                                  color: const Color(0xFF64748B),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No courses enrolled yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Enroll in courses to start learning',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: courseController.enrolledCourses.length,
                        itemBuilder: (context, index) {
                          final course =
                              courseController.enrolledCourses[index];
                          return _buildCourseCard(context, course);
                        },
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Achievements Section with enhanced design
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Achievements',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => Text(
                            '${courseController.achievements.length} earned',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      if (courseController.achievements.isEmpty) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF64748B).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.emoji_events_outlined,
                                  size: 48,
                                  color: const Color(0xFF64748B),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No achievements yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Complete courses to earn achievements',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: courseController.achievements.length,
                        itemBuilder: (context, index) {
                          final achievement =
                              courseController.achievements[index];
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF64748B).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.emoji_events,
                                  size: 32,
                                  color: Colors.amber,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  achievement.topicName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  achievement.courseName,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: const Color(0xFF64748B),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 16),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// Load user data lazily when the profile screen is accessed
  void _loadUserData() {
    try {
      // Use lazy loading - don't await the future to prevent UI blocking
      courseController.loadUserData();
      print('Started loading user data in background for profile screen');
    } catch (e) {
      print('Error starting user data loading for profile screen: $e');
    }
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EnrolledCourseScreen(course: course));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF64748B).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display course icon
            Expanded(
              child: course.icon.isNotEmpty
                  ? (course.icon.contains('.svg')
                      ? SvgPicture.asset(
                          course.icon,
                          fit: BoxFit.contain,
                          placeholderBuilder: (context) => Icon(
                            Icons.school,
                            size: 32,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : course.icon.contains('.png')
                          ? Image.asset(
                              course.icon,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.school,
                                size: 32,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          : Icon(
                              Icons.school,
                              size: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ))
                  : Icon(
                      Icons.school,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              course.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64748B).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
