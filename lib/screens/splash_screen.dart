import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/auth_controller.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeApp();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Get the controllers
      final authController = Get.find<AuthController>();
      final courseController = Get.find<CourseController>();

      // Wait for authentication state to be ready
      await _waitForAuthState(authController);

      // Start loading courses asynchronously (non-blocking)
      // This will continue in the background after navigation
      courseController.loadCoursesFromFirestore();

      // Load user data if user is logged in
      if (authController.isLoggedIn.value) {
        print('User is logged in, loading user data');
        courseController.loadUserData();
      } else {
        print('No user logged in, skipping user data load');
      }

      // Wait for just 2 seconds to show the splash screen
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to dashboard immediately - data will load in background
      // Navigate to dashboard immediately - data will load in background
      print('Navigating to dashboard...');
      if (mounted) {
        Get.offAllNamed('/dashboard');
      }
    } catch (e) {
      print('Error during splash screen: $e');
      // On error, still navigate to dashboard
      if (mounted) {
        Get.offAllNamed('/dashboard');
      }
    }
  }

  /// Wait for authentication state to be established
  Future<void> _waitForAuthState(AuthController authController) async {
    // Wait up to 3 seconds for auth state to be established
    int attempts = 0;
    while (attempts < 30) {
      // Check if Firebase auth has established the user state
      if (FirebaseAuth.instance.currentUser != null ||
          FirebaseAuth.instance.currentUser == null) {
        // Auth state is ready (either logged in or not)
        print('Auth state ready after ${attempts * 100}ms');
        break;
      }
      attempts++;
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF2563EB), // Primary blue background
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated app logo
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/logo/app_logo.png",
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // App name with modern typography
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Skill Orbit',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Subtitle/motto
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Learn. Grow. Succeed.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.95),
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Modern animated progress bar
              FadeTransition(
                opacity: _fadeAnimation,
                child: _ModernProgressBar(animation: _animationController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modern animated progress bar widget
class _ModernProgressBar extends StatelessWidget {
  final Animation<double> animation;

  const _ModernProgressBar({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // Background track
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    // Animated progress with gradient and pulse effect
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: constraints.maxWidth * animation.value,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF93C5FD),
                            const Color(0xFF60A5FA),
                            const Color(0xFF3B82F6),
                          ],
                          stops: const [0.0, 0.7, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    // Shimmer effect with enhanced animation
                    Positioned(
                      left: (constraints.maxWidth * animation.value) - 30,
                      child: Container(
                        width: 60,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.8),
                              Colors.white.withOpacity(0),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                    // Secondary pulse indicator
                    Positioned(
                      left: (constraints.maxWidth * animation.value) - 8,
                      child: Container(
                        width: 16,
                        height: constraints.maxHeight + 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
