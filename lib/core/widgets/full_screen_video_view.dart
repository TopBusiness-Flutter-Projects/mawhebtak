import 'dart:io';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import '../exports.dart';

class FullScreenViewer extends StatefulWidget {
  final String filePath;
  final String fileType;

  const FullScreenViewer({
    super.key,
    required this.filePath,
    required this.fileType,
  });

  @override
  State<FullScreenViewer> createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<FullScreenViewer> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  String? localPDFPath;
  bool isLoadingPDF = false;

  @override
  void initState() {
    super.initState();
    if (widget.fileType == 'video') {
      _videoController = VideoPlayerController.file(File(widget.filePath))
        ..initialize().then((_) {
          setState(() {
            _isVideoInitialized = true;
          });
          _videoController!.play();
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (widget.fileType) {
      case 'image':
        return PhotoViewGallery(
          pageOptions: [
            PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.filePath),
            ),
          ],
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          loadingBuilder: (context, progress) {
            return Center(
              child: CircularProgressIndicator(
                value: progress == null || progress.expectedTotalBytes == null
                    ? null
                    : progress.cumulativeBytesLoaded /
                        (progress.expectedTotalBytes ?? 0),
              ),
            );
          },
        );

      case 'video':
        if (!_isVideoInitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        return AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_videoController!),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _videoController!.value.isPlaying
                        ? _videoController!.pause()
                        : _videoController!.play();
                  });
                },
                child: Icon(
                  _videoController!.value.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );

      default:
        return const Center(
          child: Text("Unsupported file type",
              style: TextStyle(color: Colors.white)),
        );
    }
  }
}
