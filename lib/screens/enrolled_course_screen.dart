import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillorbit/controllers/course_controller.dart';
import 'package:skillorbit/models/course_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:skillorbit/controllers/theme_controller.dart';
import 'package:skillorbit/widgets/app_bar_widget.dart';

class EnrolledCourseScreen extends StatefulWidget {
  final Course course;

  const EnrolledCourseScreen({super.key, required this.course});

  @override
  State<EnrolledCourseScreen> createState() => _EnrolledCourseScreenState();
}

class _EnrolledCourseScreenState extends State<EnrolledCourseScreen> {
  final themeController = Get.put(ThemeController());
  final courseController = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.buildAppBar(themeController, context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with course info
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: widget.course.icon.isNotEmpty
                        ? (widget.course.icon.contains('.svg')
                            ? SvgPicture.asset(
                                widget.course.icon,
                                width: 80,
                                height: 80,
                                placeholderBuilder: (context) => Icon(
                                  Icons.school,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              )
                            : widget.course.icon.contains('.png')
                                ? Image.asset(
                                    widget.course.icon,
                                    width: 80,
                                    height: 80,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.school,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.school,
                                    size: 80,
                                    color: Colors.white,
                                  ))
                        : Icon(Icons.school, size: 80, color: Colors.white),
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
                  Text(
                    '${widget.course.topics.length} Topics',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Topics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Topics',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Topics List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.course.topics.length,
                    itemBuilder: (context, index) {
                      final topic = widget.course.topics[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Show "Coming Soon" badge if topic has no content
                          trailing: (topic.subtopics.isEmpty &&
                                  topic.quizQuestions.isEmpty)
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Coming Soon',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Check if topic has content (subtopics or quiz questions)
                            if (topic.subtopics.isEmpty &&
                                topic.quizQuestions.isEmpty) {
                              // Show message that content is coming soon
                              Get.snackbar(
                                'Coming Soon',
                                'This topic content is being prepared and will be available soon!',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.grey[700],
                                colorText: Colors.white,
                              );
                              return;
                            }

                            // Check if topic has subtopics
                            if (topic.subtopics.isNotEmpty) {
                              // Navigate to subtopics screen
                              Get.to(
                                () => SubtopicsScreen(
                                  topic: topic,
                                  courseName: widget.course.name,
                                ),
                              );
                            } else {
                              // Navigate to topic details screen directly
                              Get.to(
                                () => TopicDetailsScreen(
                                  topic: topic,
                                  courseName: widget.course.name,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// Subtopics Screen
class SubtopicsScreen extends StatelessWidget {
  final Topic topic;
  final String courseName;

  const SubtopicsScreen({
    super.key,
    required this.topic,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
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
                courseName,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Subtopics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${topic.subtopics.length} Subtopics',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Subtopics List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topic.subtopics.length,
                    itemBuilder: (context, index) {
                      final subtopic = topic.subtopics[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            subtopic.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Show "Coming Soon" badge if subtopic has no content
                          trailing: (subtopic.quizQuestions.isEmpty)
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Coming Soon',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Check if subtopic has content (quiz questions)
                            if (subtopic.quizQuestions.isEmpty) {
                              // Show message that content is coming soon
                              Get.snackbar(
                                'Coming Soon',
                                'This subtopic content is being prepared and will be available soon!',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.grey[700],
                                colorText: Colors.white,
                              );
                              return;
                            }

                            // Navigate to subtopic details screen
                            Get.to(
                              () => SubtopicDetailsScreen(
                                subtopic: subtopic,
                                topicName: topic.name,
                                courseName: courseName,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// Subtopic Details Screen
class SubtopicDetailsScreen extends StatefulWidget {
  final Subtopic subtopic;
  final String topicName;
  final String courseName;

  const SubtopicDetailsScreen({
    super.key,
    required this.subtopic,
    required this.topicName,
    required this.courseName,
  });

  @override
  State<SubtopicDetailsScreen> createState() => _SubtopicDetailsScreenState();
}

class _SubtopicDetailsScreenState extends State<SubtopicDetailsScreen> {
  late YoutubePlayerController? _youtubePlayerController;
  VideoPlayerController? _videoPlayerController;
  bool _videoInitialized = false;
  bool _videoError = false;
  bool _isYoutubeVideo = false;

  @override
  void initState() {
    super.initState();
    print(
        'SubtopicDetailsScreen initState called for: ${widget.subtopic.name}');
    print('Subtopic video URL: ${widget.subtopic.videoUrl}');
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _youtubePlayerController?.close();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    print('Initializing video player for URL: ${widget.subtopic.videoUrl}');
    // Only initialize if videoUrl is not empty
    if (widget.subtopic.videoUrl.isNotEmpty) {
      try {
        // Check if it's a YouTube URL
        if (_isYouTubeUrl(widget.subtopic.videoUrl)) {
          print('Detected YouTube URL');
          _isYoutubeVideo = true;

          // Extract YouTube video ID
          final videoId = _getYoutubeVideoId(widget.subtopic.videoUrl);
          if (videoId != null) {
            _youtubePlayerController = YoutubePlayerController(
              params: const YoutubePlayerParams(
                showControls: true,
                mute: false,
                showFullscreenButton: true,
                loop: false,
              ),
            );

            await _youtubePlayerController!.loadVideoById(videoId: videoId);
            print('YouTube player initialized successfully');
          } else {
            print('Could not extract YouTube video ID');
            setState(() {
              _videoError = true;
            });
          }
        } else {
          print('Initializing regular video player');
          _isYoutubeVideo = false;
          _videoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(widget.subtopic.videoUrl),
          );

          await _videoPlayerController!.initialize();
          await _videoPlayerController!.setLooping(true);

          setState(() {
            _videoInitialized = true;
          });
          print('Regular video player initialized successfully');
        }
      } catch (e) {
        print('Error initializing video player: $e');
        setState(() {
          _videoError = true;
        });
      }
    } else {
      print('No video URL provided for subtopic: ${widget.subtopic.name}');
    }
  }

  bool _isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  String? _getYoutubeVideoId(String url) {
    try {
      if (url.contains('youtube.com')) {
        final uri = Uri.parse(url);
        return uri.queryParameters['v'];
      } else if (url.contains('youtu.be')) {
        final uri = Uri.parse(url);
        return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
      }
    } catch (e) {
      print('Error extracting YouTube video ID: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('Building SubtopicDetailsScreen for: ${widget.subtopic.name}');
    print('Video URL: ${widget.subtopic.videoUrl}');
    print('Video URL is empty: ${widget.subtopic.videoUrl.isEmpty}');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subtopic.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with subtopic info
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
                    widget.topicName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtopic.name,
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.subtopic.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Tutorial Link Section
            if (widget.subtopic.tutorialLink.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tutorial Link',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri.parse(widget.subtopic.tutorialLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          if (mounted) {
                            Get.snackbar(
                              'Error',
                              'Could not open the link',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
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
                                widget.subtopic.tutorialLink,
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

            // Video Player Section
            if (widget.subtopic.videoUrl.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Video Tutorial',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 12),
                    Container(
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
                          if (_videoError)
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      size: 48,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Failed to load video',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'The video could not be loaded. Please check the video URL or try again later.',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: _initializeVideoPlayer,
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (_isYoutubeVideo &&
                              _youtubePlayerController != null)
                            Container(
                              height: 200,
                              child: YoutubePlayer(
                                controller: _youtubePlayerController!,
                                aspectRatio: 16 / 9,
                              ),
                            )
                          else if (_videoInitialized &&
                              _videoPlayerController != null)
                            AspectRatio(
                              aspectRatio:
                                  _videoPlayerController!.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController!),
                            )
                          else if (widget.subtopic.videoUrl.isNotEmpty)
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(16),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(16),
                              child: const Center(
                                child: Text('No video available'),
                              ),
                            ),
                          if (!_isYoutubeVideo &&
                              _videoInitialized &&
                              _videoPlayerController != null)
                            VideoProgressIndicator(
                              _videoPlayerController!,
                              allowScrubbing: true,
                            ),
                          if (!_isYoutubeVideo &&
                              _videoInitialized &&
                              _videoPlayerController != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      _videoPlayerController!.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_videoPlayerController!
                                            .value.isPlaying) {
                                          _videoPlayerController!.pause();
                                        } else {
                                          _videoPlayerController!.play();
                                        }
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.replay),
                                    onPressed: () {
                                      _videoPlayerController!.seekTo(
                                        Duration.zero,
                                      );
                                      _videoPlayerController!.play();
                                    },
                                  ),
                                ],
                              ),
                            ),
                        ],
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
                    // Navigate to quiz screen
                    Get.to(
                      () => SubtopicQuizScreen(
                        subtopic: widget.subtopic,
                        topicName: widget.topicName,
                        courseName: widget.courseName,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 1,
                  ),
                  child: const Text('Take Quiz'),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Subtopic Quiz Screen
class SubtopicQuizScreen extends StatefulWidget {
  final Subtopic subtopic;
  final String topicName;
  final String courseName;

  const SubtopicQuizScreen({
    super.key,
    required this.subtopic,
    required this.topicName,
    required this.courseName,
  });

  @override
  State<SubtopicQuizScreen> createState() => _SubtopicQuizScreenState();
}

class _SubtopicQuizScreenState extends State<SubtopicQuizScreen> {
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];
  bool showResults = false;
  int score = 0;
  final courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.subtopic.quizQuestions.length, null);
  }

  void selectAnswer(int optionIndex) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = optionIndex;
    });
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.subtopic.quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Calculate score and show results
      calculateScore();
      setState(() {
        showResults = true;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void calculateScore() {
    score = 0;
    for (int i = 0; i < widget.subtopic.quizQuestions.length; i++) {
      if (selectedAnswers[i] ==
          widget.subtopic.quizQuestions[i].correctAnswerIndex) {
        score++;
      }
    }
  }

  void submitQuiz() {
    try {
      // Add achievement
      final achievement = Achievement(
        topicName: '${widget.topicName} - ${widget.subtopic.name}',
        courseName: widget.courseName,
        dateCompleted: DateTime.now(),
      );
      courseController.addAchievement(achievement);

      // Show completion message
      Get.snackbar(
        'Quiz Completed!',
        'You scored $score/${widget.subtopic.quizQuestions.length}. Subtopic completed successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Don't navigate away immediately, let the user see the snackbar
      // The snackbar will be visible on the current page
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to complete subtopic. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error completing subtopic: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showResults) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Results'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Your Score: $score/${widget.subtopic.quizQuestions.length}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: LinearProgressIndicator(
                  value: score / widget.subtopic.quizQuestions.length,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  score >= widget.subtopic.quizQuestions.length * 0.7
                      ? 'Congratulations! You passed the quiz.'
                      : 'Keep studying and try again!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: submitQuiz,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Complete Subtopic'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final question = widget.subtopic.quizQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question ${currentQuestionIndex + 1}/${widget.subtopic.quizQuestions.length}',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) /
                  widget.subtopic.quizQuestions.length,
              minHeight: 5,
            ),

            const SizedBox(height: 24),

            // Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: List.generate(question.options.length, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: selectedAnswers[currentQuestionIndex] == index
                          ? Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2)
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedAnswers[currentQuestionIndex] == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: RadioListTile<int>(
                      title: Text(question.options[index]),
                      value: index,
                      groupValue: selectedAnswers[currentQuestionIndex],
                      onChanged: (value) {
                        selectAnswer(value!);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 32),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  if (currentQuestionIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: goToPreviousQuestion,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Previous'),
                      ),
                    ),
                  if (currentQuestionIndex > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: selectedAnswers[currentQuestionIndex] != null
                          ? goToNextQuestion
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex ==
                                widget.subtopic.quizQuestions.length - 1
                            ? 'Submit Quiz'
                            : 'Next',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Modified Topic Details Screen to handle topics without subtopics
class TopicDetailsScreen extends StatelessWidget {
  final Topic topic;
  final String courseName;

  const TopicDetailsScreen({
    super.key,
    required this.topic,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
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
                courseName,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
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
                    padding: const EdgeInsets.all(16.0),
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
                    child: Text(
                      topic.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Tutorial Link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tutorial',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16.0),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Learn more about this topic:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            // Open tutorial link
                            // In a real app, you would use url_launcher package
                            launchUrl(
                              Uri.parse(topic.tutorialLink),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.link),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    topic.tutorialLink,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
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
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quiz Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to quiz screen
                    Get.to(
                      () => QuizScreen(topic: topic, courseName: courseName),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 1,
                  ),
                  child: const Text('Take Quiz'),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Quiz Screen
class QuizScreen extends StatefulWidget {
  final Topic topic;
  final String courseName;

  const QuizScreen({super.key, required this.topic, required this.courseName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];
  bool showResults = false;
  int score = 0;
  final courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.topic.quizQuestions.length, null);
  }

  void selectAnswer(int optionIndex) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = optionIndex;
    });
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.topic.quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Calculate score and show results
      calculateScore();
      setState(() {
        showResults = true;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void calculateScore() {
    score = 0;
    for (int i = 0; i < widget.topic.quizQuestions.length; i++) {
      if (selectedAnswers[i] ==
          widget.topic.quizQuestions[i].correctAnswerIndex) {
        score++;
      }
    }
  }

  void submitQuiz() {
    try {
      // Add achievement
      final achievement = Achievement(
        topicName: widget.topic.name,
        courseName: widget.courseName,
        dateCompleted: DateTime.now(),
      );
      courseController.addAchievement(achievement);

      // Show completion message
      Get.snackbar(
        'Quiz Completed!',
        'You scored $score/${widget.topic.quizQuestions.length}. Topic completed successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Don't navigate away immediately, let the user see the snackbar
      // The snackbar will be visible on the current page
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to complete topic. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error completing topic: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showResults) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Results'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Your Score: $score/${widget.topic.quizQuestions.length}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: LinearProgressIndicator(
                  value: score / widget.topic.quizQuestions.length,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  score >= widget.topic.quizQuestions.length * 0.7
                      ? 'Congratulations! You passed the quiz.'
                      : 'Keep studying and try again!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: submitQuiz,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Complete Topic'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final question = widget.topic.quizQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question ${currentQuestionIndex + 1}/${widget.topic.quizQuestions.length}',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) /
                  widget.topic.quizQuestions.length,
              minHeight: 5,
            ),

            const SizedBox(height: 24),

            // Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: List.generate(question.options.length, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: selectedAnswers[currentQuestionIndex] == index
                          ? Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2)
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedAnswers[currentQuestionIndex] == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: RadioListTile<int>(
                      title: Text(question.options[index]),
                      value: index,
                      groupValue: selectedAnswers[currentQuestionIndex],
                      onChanged: (value) {
                        selectAnswer(value!);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 32),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  if (currentQuestionIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: goToPreviousQuestion,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Previous'),
                      ),
                    ),
                  if (currentQuestionIndex > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: selectedAnswers[currentQuestionIndex] != null
                          ? goToNextQuestion
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex ==
                                widget.topic.quizQuestions.length - 1
                            ? 'Submit Quiz'
                            : 'Next',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
