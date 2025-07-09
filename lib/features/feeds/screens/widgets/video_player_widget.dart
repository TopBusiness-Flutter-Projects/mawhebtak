import 'package:flutter/material.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          // لا تشغل الفيديو تلقائيًا
        }
      }).catchError((error) {
        setState(() {
          _isError = true;
        });
        print('Video initialization error: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Center(
        child: Image.asset(ImageAssets.appIconWhite),
      );
    }

    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return  Center(
      child: _controller.value.isInitialized
          ? GestureDetector(
        onTap: _togglePlayPause,
        child: FittedBox(
          fit: BoxFit.contain, // مهم علشان ما يضغطش الفيديو
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                VideoProgressIndicator(_controller,
                    allowScrubbing: true),
                if (!_controller.value.isPlaying)
                  const Center(
                    child: Icon(Icons.play_circle_fill,
                        size: 64, color: Colors.white70),
                  ),
              ],
            ),
          ),
        ),
      )
          : const CircularProgressIndicator(),
    );

  }
}
