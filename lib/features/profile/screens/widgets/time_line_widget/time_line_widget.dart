import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/feeds/screens/feeds_screen.dart';
import 'package:mawhebtak/features/profile/screens/widgets/time_line_widget/time_line_list.dart';
import 'package:mawhebtak/features/profile/screens/widgets/time_line_widget/what_do_you_want.dart';

import '../../../../../core/exports.dart';
import '../../../../events/screens/widgets/custom_row_event.dart';
import '../about_widgets/custom_row_section.dart';
import '../about_widgets/experince_widget.dart';
import 'like_comment_share.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({super.key, this.feeds, this.feedsCubit, required this.postId});
  final  PostsModelData? feeds;
  final FeedsCubit ? feedsCubit;
  final String postId;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.h,
        ),
        //what do you want
        const WhatDoYouWant(),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return  TimeLineList(
              postId:postId ,
              feedsCubit: feedsCubit,
              feeds: feeds,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 15.h,
            );
          },
        ),
        SizedBox(
          height: 100.h,
        )
      ],
    );
  }
}
