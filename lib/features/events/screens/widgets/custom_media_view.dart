import 'package:carousel_slider/carousel_slider.dart';
import 'package:mawhebtak/features/events/data/model/event_details_model.dart';

import '../../../../core/exports.dart';
import '../../../../core/widgets/full_screen_video_view.dart';

class MediaCarousel extends StatelessWidget {
  final List<Media> mediaList;

  const MediaCarousel({Key? key, required this.mediaList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: mediaList.length,
      itemBuilder: (context, index, realIndex) {
        final media = mediaList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenViewer(
                    filePath: media.file ?? '',
                    fileType: media.extension ?? ''),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: media.extension == 'video'
                    ? const AssetImage(ImageAssets.videoImage) as ImageProvider
                    : NetworkImage(media.file ?? ''),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 220.h,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}
