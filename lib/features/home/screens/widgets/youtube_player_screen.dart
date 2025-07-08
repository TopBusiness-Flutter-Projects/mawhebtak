
import 'package:mawhebtak/core/exports.dart';
import 'package:youtube_quality_player/youtube_quality_player.dart';



class YouTubePlayerScreen extends StatefulWidget {
  final String videoLink;

  const YouTubePlayerScreen({super.key, required this.videoLink});

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}
class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Quality Player'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250.h,
            child: YQPlayer(
              videoLink: widget.videoLink,
              primaryColor: Colors.blue,
              secondaryColor: Colors.redAccent,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
