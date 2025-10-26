import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/widgets/gradient_circular_progress_indicator_widget.dart';

class EnhancedAchievementsScreen extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();

  EnhancedAchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievement Progress'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Obx(() {
        // Calculate progress statistics
        final totalAchievements = courseController.achievements.length;
        final achievementsByCourse = _groupAchievementsByCourse();
        final coursesWithAchievements = achievementsByCourse.keys.toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with overall progress
              _buildProgressHeader(context, totalAchievements),

              const SizedBox(height: 24),

              // Course-wise progress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Course Progress',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Progress cards for each course
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: coursesWithAchievements.length,
                  itemBuilder: (context, index) {
                    final courseName = coursesWithAchievements[index];
                    final achievements = achievementsByCourse[courseName]!;
                    return _buildCourseProgressCard(
                      context,
                      courseName,
                      achievements,
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Detailed achievements list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'All Achievements',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Achievements timeline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(child: _buildAchievementsTimeline(context)),
              ),

              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProgressHeader(BuildContext context, int totalAchievements) {
    // Calculate overall progress based on subtopics
    final overallProgress = courseController.getOverallProgressBySubtopics();
    final totalSubtopics = courseController.enrolledCourses.fold(
      0,
      (sum, course) =>
          sum + courseController.getTotalSubtopicsForCourse(course.name),
    );
    final completedSubtopics = courseController.enrolledCourses.fold(
      0,
      (sum, course) =>
          sum + courseController.getCompletedSubtopicsForCourse(course.name),
    );

    return Container(
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
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Achievement Progress',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedSubtopics of $totalSubtopics subtopics completed',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          // Progress ring using the same style as home screen
          SizedBox(
            width: 120,
            height: 120,
            child: GradientCircularProgressIndicator(
              progress: overallProgress,
              strokeWidth: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Center(
                child: Text(
                  '${overallProgress.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseProgressCard(
    BuildContext context,
    String courseName,
    List<Achievement> achievements,
  ) {
    // Calculate progress based on subtopics
    final totalSubtopics = courseController.getTotalSubtopicsForCourse(
      courseName,
    );
    final completedSubtopics = courseController.getCompletedSubtopicsForCourse(
      courseName,
    );
    final progress = totalSubtopics > 0
        ? (completedSubtopics / totalSubtopics)
        : 0.0;
    final progressPercentage = progress * 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getIconForCourse(courseName),
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  courseName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$completedSubtopics/$totalSubtopics subtopics',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Progress indicator using the same style as home screen
            Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: GradientCircularProgressIndicator(
                    progress: progressPercentage,
                    strokeWidth: 6,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Text(
                        '${progressPercentage.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Course Progress',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      // Linear progress bar as secondary indicator
                      SizedBox(
                        height: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getProgressColor(progress),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$completedSubtopics of $totalSubtopics subtopics completed',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsTimeline(BuildContext context) {
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
            Icon(Icons.emoji_events_outlined, size: 48, color: Colors.grey),
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

    // Sort achievements by date (newest first)
    final sortedAchievements =
        List<Achievement>.from(courseController.achievements)..sort((a, b) {
          return b.dateCompleted.compareTo(a.dateCompleted);
        });

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
        itemCount: sortedAchievements.length,
        itemBuilder: (context, index) {
          final achievement = sortedAchievements[index];
          return Container(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: index == 0 ? 16 : 8,
              bottom: index == sortedAchievements.length - 1 ? 16 : 8,
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
                      : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  index == 0 ? Icons.emoji_events : Icons.emoji_events_outlined,
                  color: index == 0
                      ? Colors.amber
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(
                achievement.topicName,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
  }

  Map<String, List<Achievement>> _groupAchievementsByCourse() {
    final Map<String, List<Achievement>> grouped = {};
    for (var achievement in courseController.achievements) {
      if (!grouped.containsKey(achievement.courseName)) {
        grouped[achievement.courseName] = [];
      }
      grouped[achievement.courseName]!.add(achievement);
    }
    return grouped;
  }

  IconData _getIconForCourse(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android;
      case 'c':
      case 'c++':
        return Icons.code_sharp;
      case 'java':
        return Icons.coffee_outlined;
      case 'database':
        return Icons.storage_rounded;
      case 'mysql':
        return Icons.dns_outlined;
      case 'html':
        return Icons.web_asset;
      default:
        return Icons.school_outlined;
    }
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.8) {
      return Colors.green;
    } else if (progress >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
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
