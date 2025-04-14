import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/screens/widgets/under_custom_row.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mawhebtak/features/home/screens/widgets/custom_row.dart';
import '../../../core/exports.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/video.mp4")
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Container(
        height: getHeightSize(context),
        width: getWidthSize(context),
        color: AppColors.primaryScreen,
        child: Column(
          children: [
            Stack(
              children: [
                const SizedBox(height: 16),

                Padding(
                  padding: EdgeInsets.all(0), // يمكن ضبط الحشو حسب الحاجة
                  child: Container(
                    color: AppColors.gray,
                    height: getHeightSize(context) / 2,
                    width: getWidthSize(context),
                    child: Column(
                      children: [
                        // هنا يمكنك تضمين الفيديو إذا أردت
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: CustomRow(), // سيتم عرض CustomRow فوق الفيديو
                ),
                const SizedBox(height: 16),
                UnderCustomRow()
                // Positioned(
                //   bottom: 50, // تضع الصورة في أسفل الـ Container
                //   left: 30, // تضع الصورة في الجهة اليسرى
                //   child: SizedBox(
                //     height: 40.h,
                //     width: 40.w,
                //     child: Image.asset(ImageAssets.profileImage),
                //   ),
                // ),
                // Positioned(
                //     bottom: 25, // تضع الصورة في أسفل الـ Container
                //     left: 30,
                //     child: Text("Ahmed Mokhtar",style: getMediumStyle(color: AppColors.white),))
                //
                // // وضع الصورة في الأسفل على اليسار باستخدام Positioned

              ],
            ),
          ],
        ),
      );
    });
  }
}
