import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/under_custom_row.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import '../../../core/exports.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../follow_button.dart';
final List<_HomeItem> items = [
  _HomeItem(icon: Icons.event, label: 'Events'),
  _HomeItem(icon: Icons.leaderboard, label: 'Events'),
  _HomeItem(icon: Icons.announcement, label: 'Casting'),
  _HomeItem(icon: Icons.announcement, label: 'Announce'),
  _HomeItem(icon: Icons.announcement, label: 'Announce'),
  _HomeItem(icon: Icons.work, label: 'Jobs'),
  _HomeItem(icon: Icons.work, label: 'Jobs'),

];

class _HomeItem {
  final IconData icon;
  final String label;

  _HomeItem({required this.icon, required this.label});
}
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
      return Scaffold(
        body: Container(
        //  height: getHeightSize(context),
          width: getWidthSize(context),
          color: AppColors.homeColor,
          child: ListView(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: getHeightSize(context) / 1.5,
                    width: getWidthSize(context),
                    child: Image.asset(
                      ImageAssets.testImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 16,
                    right: 16,
                    child: CustomAppBarRow(),
                  ),
                  UnderCustomRow(),
                  CustomList(),
                ],
              ),
              SizedBox(height: 10.h),
              CustomRow(text: 'top_talents',),
              SizedBox(height: 4.h,),
              SizedBox(
                   height: 184.h,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount:items.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                  return CustomTopTalentsList(isLeftPadding:index==0?true:false, isRightPadding: index==items.length-1?true:false,);
                },),
              ),
              CustomRow(text: 'top_events',),
              SizedBox(height: 4.h,),

              SizedBox(
                height: 215.h,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount:items.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomTopEventList(isLeftPadding:index==0?true:false, isRightPadding: index==items.length-1?true:false,);
                  },),
              ),
              SizedBox(height: 60.h),

            ],
          ),
        ),
      );
    });
  }
}
