import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;
  bool _hasError = false;
  String _errorMessage = '';
  String? _videoId;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    print('VideoPlayerWidget initState called');
    print('Video URL: ${widget.videoUrl}');
    _initializePlayer();
  }

  void _initializePlayer() {
    try {
      // Extract video ID from URL
      _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
      print('Extracted video ID: $_videoId');

      if (_videoId != null && _videoId!.isNotEmpty) {
        // Create controller
        _controller = YoutubePlayerController(
          initialVideoId: _videoId!,
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          ),
        );

        // Listen to controller events
        _controller!.addListener(_controllerListener);

        // Mark as initialized
        setState(() {
          _isInitialized = true;
        });

        print('YouTube player controller initialized successfully');
      } else {
        // Handle invalid URL
        print('Invalid video URL - could not extract video ID');
        setState(() {
          _isInitialized = true;
          _isPlayerReady = true;
          _hasError = true;
          _errorMessage = 'Invalid YouTube URL';
        });
      }
    } catch (e) {
      print('Error initializing YouTube player: $e');
      setState(() {
        _isInitialized = true;
        _isPlayerReady = true;
        _hasError = true;
        _errorMessage = 'Error initializing video player: $e';
      });
    }
  }

  void _controllerListener() {
    if (_controller != null && mounted) {
      if (_controller!.value.isReady && !_isPlayerReady) {
        print('YouTube player is ready');
        setState(() {
          _isPlayerReady = true;
          _hasError = false;
        });
      }

      if (_controller!.value.hasError) {
        print('YouTube player error: ${_controller!.value.errorCode}');
        setState(() {
          _isPlayerReady = true;
          _hasError = true;
          _errorMessage = 'Video playback error';
        });
      }
    }
  }

  Future<void> _launchVideoUrl() async {
    final Uri url = Uri.parse(widget.videoUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch video URL')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'VideoPlayerWidget build - videoUrl: ${widget.videoUrl}, videoId: $_videoId, isInitialized: $_isInitialized, isPlayerReady: $_isPlayerReady, hasError: $_hasError');

    // Check if video URL is empty
    if (widget.videoUrl.isEmpty) {
      print('VideoPlayerWidget - No video URL provided');
      return _buildNoVideoUI(context);
    }

    // If not initialized yet, show loading
    if (!_isInitialized) {
      return _buildLoadingUI(context);
    }

    // If we have an error, show fallback UI with option to open in browser
    if (_hasError) {
      return _buildErrorUI(context);
    }

    // Show the video player
    return _buildPlayerUI(context);
  }

  Widget _buildNoVideoUI(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.video_library, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No video available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingUI(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Initializing video player...'),
        ],
      ),
    );
  }

  Widget _buildErrorUI(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_circle_outline,
                    size: 48, color: Colors.white),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _errorMessage.isEmpty
                        ? 'Video player unavailable'
                        : _errorMessage,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Watch this video tutorial in your browser',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _launchVideoUrl,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('Watch on YouTube'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Video Tutorial',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Video ID: $_videoId',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerUI(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: _controller != null
                ? YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor:
                        Theme.of(context).colorScheme.primary,
                    onReady: () {
                      print('YouTube player onReady callback');
                      if (mounted && !_isPlayerReady) {
                        setState(() {
                          _isPlayerReady = true;
                        });
                      }
                    },
                    onEnded: (metadata) {
                      print('Video ended');
                    },
                  )
                : Container(
                    height: 200,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Video Tutorial',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Video ID: $_videoId',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: _launchVideoUrl,
                      icon: const Icon(Icons.open_in_browser, size: 16),
                      label: const Text('Open in YouTube'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('VideoPlayerWidget dispose called');
    if (_controller != null) {
      _controller!.removeListener(_controllerListener);
      _controller!.dispose();
    }
    super.dispose();
  }
}
