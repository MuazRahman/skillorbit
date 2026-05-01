import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/controllers/dashboard_controller.dart';
import 'package:skillorbit/models/course_model.dart';
import 'package:skillorbit/widgets/course_icon_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/widgets/app_bar_widget.dart';
import 'package:skillorbit/widgets/video_player_widget.dart';
import 'package:skillorbit/screens/dashboard_screen.dart' as dashboard_view;

class EnrolledCourseScreen extends StatefulWidget {
  final Course course;

  const EnrolledCourseScreen({super.key, required this.course});

  @override
  State<EnrolledCourseScreen> createState() => _EnrolledCourseScreenState();
}

class _EnrolledCourseScreenState extends State<EnrolledCourseScreen> {
  final themeController = Get.find<ThemeController>();
  final courseController = Get.find<CourseController>();
  bool isLoadingModules = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadModules();
    });
  }

  Future<void> _loadModules() async {
    // Always fetch fresh from Firestore to pick up admin changes
    await courseController.getModulesForCourse(widget.course.id, forceRefresh: true);
    if (mounted) {
      setState(() {
        isLoadingModules = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.buildAppBar(themeController, context),
      body: RefreshIndicator(
        onRefresh: () async {
          // Clear module cache for this course and re-fetch
          await courseController.getModulesForCourse(widget.course.id, forceRefresh: true);
          await courseController.refreshAllData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Header with course info
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
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
                  child: widget.course.imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.network(
                            widget.course.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(),
                          ),
                        )
                      : null,
                ),
                if (widget.course.imageUrl.isNotEmpty)
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CourseIconWidget(
                          iconPath: widget.course.icon,
                          size: 50,
                          iconSize: 50,
                          backgroundColor: Colors.transparent,
                          defaultIconColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.course.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() {
                        final modules =
                            courseController.courseModules[widget.course.id] ??
                                [];
                        return Text(
                          '${modules.length} Modules',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Modules Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Modules',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  if (isLoadingModules)
                    const Center(child: CircularProgressIndicator())
                  else
                    Obx(() {
                      final modules =
                          courseController.courseModules[widget.course.id] ??
                              [];
                      if (modules.isEmpty) {
                        return const Center(
                            child: Text('No modules available yet.'));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: modules.length,
                        itemBuilder: (context, index) {
                          final module = modules[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF64748B).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(
                                module.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Get.to(() => ModuleTopicsScreen(
                                      module: module,
                                      courseName: widget.course.name,
                                    ));
                              },
                            ),
                          );
                        },
                      );
                    }),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      ),
    );
  }
}

// Module Topics Screen (formerly Subtopics Screen)
class ModuleTopicsScreen extends StatefulWidget {
  final Module module;
  final String courseName;

  const ModuleTopicsScreen({
    super.key,
    required this.module,
    required this.courseName,
  });

  @override
  State<ModuleTopicsScreen> createState() => _ModuleTopicsScreenState();
}

class _ModuleTopicsScreenState extends State<ModuleTopicsScreen> {
  final courseController = Get.find<CourseController>();
  bool isLoadingTopics = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTopics();
    });
  }

  Future<void> _loadTopics() async {
    // Always fetch fresh from Firestore to pick up admin changes
    await courseController.getTopicsForModule(widget.module.id, forceRefresh: true);
    if (mounted) {
      setState(() {
        isLoadingTopics = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module.name),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Clear topic cache for this module and re-fetch
          await courseController.getTopicsForModule(widget.module.id, forceRefresh: true);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              child: Text(
                widget.courseName,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Topics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final topics =
                        courseController.moduleTopics[widget.module.id] ?? [];
                    return Text(
                      '${topics.length} Topics',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    );
                  }),
                  const SizedBox(height: 16),
                  if (isLoadingTopics)
                    const Center(child: CircularProgressIndicator())
                  else
                    Obx(() {
                      final topics =
                          courseController.moduleTopics[widget.module.id] ?? [];
                      if (topics.isEmpty) {
                        return const Center(
                            child: Text('No topics available yet.'));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: topics.length,
                        itemBuilder: (context, index) {
                          final topic = topics[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF64748B).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(
                                topic.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Get.to(() => TopicDetailsScreen(
                                      topic: topic,
                                      moduleName: widget.module.name,
                                      courseName: widget.courseName,
                                    ));
                              },
                            ),
                          );
                        },
                      );
                    }),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      ),
    );
  }
}

// Topic Details Screen (formerly Subtopic Details Screen)
class TopicDetailsScreen extends StatefulWidget {
  final Topic topic;
  final String moduleName;
  final String courseName;

  const TopicDetailsScreen({
    super.key,
    required this.topic,
    required this.moduleName,
    required this.courseName,
  });

  @override
  State<TopicDetailsScreen> createState() => _TopicDetailsScreenState();
}

class _TopicDetailsScreenState extends State<TopicDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with topic info
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.moduleName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.topic.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.courseName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF64748B).withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.topic.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Video Player Section (YouTube)
            if (widget.topic.videoUrl.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: VideoPlayerWidget(videoUrl: widget.topic.videoUrl),
              ),
              const SizedBox(height: 24),
            ],

            // Tutorial Link Section (Topic Doc)
            if (widget.topic.tutorialLink.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Resource',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri.parse(widget.topic.tutorialLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.link),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.topic.tutorialLink,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Quiz Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => TopicQuizScreen(
                          parentId: widget.topic.id,
                          parentName: widget.topic.name,
                          courseName: widget.courseName,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Take Quiz'),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// Topic Quiz Screen (formerly Subtopic Quiz Screen)
class TopicQuizScreen extends StatefulWidget {
  final String parentId;
  final String parentName;
  final String courseName;

  const TopicQuizScreen({
    super.key,
    required this.parentId,
    required this.parentName,
    required this.courseName,
  });

  @override
  State<TopicQuizScreen> createState() => _TopicQuizScreenState();
}

class _TopicQuizScreenState extends State<TopicQuizScreen> {
  final courseController = Get.find<CourseController>();
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];
  bool showResults = false;
  bool isQuizSubmitted = false;
  int score = 0;
  bool isLoadingQuizzes = true;
  List<QuizQuestion> quizzes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQuizzes();
    });
  }

  Future<void> _loadQuizzes() async {
    // Always fetch fresh from Firestore to pick up admin changes
    quizzes = await courseController.getQuizzes(widget.parentId, forceRefresh: true);
    if (mounted) {
      setState(() {
        selectedAnswers = List.filled(quizzes.length, null);
        isLoadingQuizzes = false;
      });
    }
  }

  void selectAnswer(int optionIndex) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = optionIndex;
    });
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < quizzes.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      calculateScore();
      submitQuiz();
    }
  }

  void calculateScore() {
    score = 0;
    for (int i = 0; i < quizzes.length; i++) {
      if (selectedAnswers[i] == quizzes[i].correctAnswerIndex) {
        score++;
      }
    }
  }

  void submitQuiz() {
    final achievement = Achievement(
      topicName: widget.parentName,
      courseName: widget.courseName,
      dateCompleted: DateTime.now(),
    );
    courseController.addAchievement(achievement);
    setState(() {
      showResults = true;
      isQuizSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingQuizzes) {
      return Scaffold(body: const Center(child: CircularProgressIndicator()));
    }
    if (quizzes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(
            child: Text('No quiz questions available for this topic.')),
      );
    }

    if (showResults) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Results')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Score: $score/${quizzes.length}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  try {
                    final dashboardController = Get.find<DashBoardController>();
                    dashboardController.currentPageIndex.value =
                        2; // Profile screen index
                  } catch (e) {
                    print('DashBoardController not found: $e');
                  }
                  // Navigate to Dashboard (which will show the Profile tab)
                  Get.offAllNamed('/dashboard');
                },
                child: const Text('Finish and View Achievements'),
              ),
            ],
          ),
        ),
      );
    }

    final question = quizzes[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Question ${currentQuestionIndex + 1}/${quizzes.length}')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.question,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...List.generate(question.options.length, (index) {
              return ListTile(
                title: Text(question.options[index]),
                leading: Radio<int>(
                  value: index,
                  groupValue: selectedAnswers[currentQuestionIndex],
                  onChanged: (val) => selectAnswer(index),
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedAnswers[currentQuestionIndex] == null
                    ? null
                    : goToNextQuestion,
                child: Text(currentQuestionIndex == quizzes.length - 1
                    ? 'Finish'
                    : 'Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
