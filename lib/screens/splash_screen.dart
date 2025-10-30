import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/screens/dashboard_screen.dart';

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
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Get the course controller
      final courseController = Get.find<CourseController>();

      // Start loading courses asynchronously (non-blocking)
      courseController.loadCoursesFromFirestore();

      // Wait for 2 seconds to show the splash screen
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to the dashboard screen (which will show the home screen by default)
      if (mounted) {
        Get.offAll(() => const DashboardScreen());
      }
    } catch (e) {
      print('Error during splash screen: $e');
      // Even if there's an error, we still navigate to the app
      if (mounted) {
        Get.offAll(() => const DashboardScreen());
      }
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
        color: const Color(0xFF4CAF50), // Green background
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
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.auto_graph,
                      size: 80,
                      color: const Color(0xFF4CAF50), // Green icon
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // App name with modern typography
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Skill Orbit',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Subtitle/motto
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Learn. Grow. Succeed.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 50),
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
      width: 200,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
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
                    // Animated progress
                    Container(
                      width: constraints.maxWidth * animation.value,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.white.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    // Shimmer effect
                    Positioned(
                      left: (constraints.maxWidth * animation.value) - 20,
                      child: Container(
                        width: 40,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
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
