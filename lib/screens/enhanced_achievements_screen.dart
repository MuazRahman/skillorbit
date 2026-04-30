import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/models/course_model.dart';
import 'package:skillorbit/widgets/gradient_circular_progress_indicator_widget.dart';

class EnhancedAchievementsScreen extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();

  EnhancedAchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievement Progress'),
      ),
      body: Obx(() {
        final totalAchievements = courseController.achievements.length;
        final achievementsByCourse = _groupAchievementsByCourse();
        final coursesWithAchievements = achievementsByCourse.keys.toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressHeader(context, totalAchievements),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Course Achievements',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: coursesWithAchievements.length,
                  itemBuilder: (context, index) {
                    final courseName = coursesWithAchievements[index];
                    final achievements = achievementsByCourse[courseName]!;
                    return _buildCourseProgressCard(context, courseName, achievements);
                  },
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'All Achievements',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildAchievementsTimeline(context),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProgressHeader(BuildContext context, int totalAchievements) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
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
          const Text('Your Achievements', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text('Total $totalAchievements earned', style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9))),
        ],
      ),
    );
  }

  Widget _buildCourseProgressCard(BuildContext context, String courseName, List<Achievement> achievements) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(_getIconForCourse(courseName), color: Theme.of(context).colorScheme.primary, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(courseName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('${achievements.length} topic(s) completed', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTimeline(BuildContext context) {
    final achievements = courseController.achievements;
    if (achievements.isEmpty) {
      return const Center(child: Text('No achievements yet.'));
    }
    return Column(
      children: achievements.map((a) => ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(a.topicName),
        subtitle: Text('${a.courseName} • ${_formatDate(a.dateCompleted)}'),
      )).toList(),
    );
  }

  Map<String, List<Achievement>> _groupAchievementsByCourse() {
    final Map<String, List<Achievement>> grouped = {};
    for (var achievement in courseController.achievements) {
      grouped.putIfAbsent(achievement.courseName, () => []).add(achievement);
    }
    return grouped;
  }

  IconData _getIconForCourse(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'flutter': return Icons.phone_android;
      case 'c':
      case 'c++': return Icons.code_sharp;
      default: return Icons.school;
    }
  }

  static String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
