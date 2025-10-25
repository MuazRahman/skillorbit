import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/controllers/dashboard_controller.dart';
import 'package:skillorbit/screens/enhanced_achievements_screen.dart';
import 'package:skillorbit/screens/my_course_screen.dart';

class ProfileScreen extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Simulate refresh action
        await Future.delayed(const Duration(seconds: 1));
        // In a real app, you might want to refresh data from an API here
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
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Container(
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
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learning Enthusiast',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
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
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Row(
                      children: [
                        _buildEnhancedStatCard(
                          context,
                          'Courses',
                          courseController.enrolledCourses.length.toString(),
                          Icons.school,
                          Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        _buildEnhancedStatCard(
                          context,
                          'Achievements',
                          courseController.achievements.length.toString(),
                          Icons.emoji_events,
                          Colors.amber,
                        ),
                      ],
                    ),
                  ),
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
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Text(
                          '${courseController.achievements.length} earned',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Obx(() {
                    if (courseController.achievements.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
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
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No achievements yet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Complete quizzes to earn achievements',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: courseController.achievements.length,
                        itemBuilder: (context, index) {
                          final achievement =
                              courseController.achievements[index];
                          return Container(
                            margin: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: index == 0 ? 16 : 8,
                              bottom:
                                  index ==
                                      courseController.achievements.length - 1
                                  ? 16
                                  : 8,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: index == 0
                                    ? Colors.amber.withOpacity(0.5)
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? Colors.amber.withOpacity(0.2)
                                      : Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  index == 0
                                      ? Icons.emoji_events
                                      : Icons.emoji_events_outlined,
                                  color: index == 0
                                      ? Colors.amber
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              title: Text(
                                achievement.topicName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${achievement.courseName} • ${_formatDate(achievement.dateCompleted)}',
                              ),
                              trailing: index == 0
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'NEW',
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                // Show achievement details
                                _showAchievementDetails(context, achievement);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 32),
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
    Color color,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigate to enhanced achievements screen when achievements card is tapped
          if (title == 'Achievements') {
            Get.to(() => EnhancedAchievementsScreen());
          }
          // Navigate to My Course screen through Bottom Navigation Bar when courses card is tapped
          else if (title == 'Courses') {
            // Get the dashboard controller and set the current page index to 1 (My Course screen)
            final dashboardController = Get.find<DashBoardController>();
            dashboardController.currentPageIndex.value = 1;
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showAchievementDetails(BuildContext context, Achievement achievement) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, size: 64, color: Colors.amber),
              const SizedBox(height: 16),
              Text(
                achievement.topicName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                achievement.courseName,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Completed on ${_formatDate(achievement.dateCompleted)}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Congratulations on completing this topic!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
