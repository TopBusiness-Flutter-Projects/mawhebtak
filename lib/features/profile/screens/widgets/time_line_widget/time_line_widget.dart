import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/profile/screens/widgets/time_line_widget/time_line_list.dart';
import 'package:mawhebtak/features/profile/screens/widgets/time_line_widget/what_do_you_want.dart';

import '../../../../../core/exports.dart';
import '../../../../events/screens/widgets/custom_row_event.dart';
import '../about_widgets/custom_row_section.dart';
import '../about_widgets/experince_widget.dart';
import 'like_comment_share.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        SizedBox(height: 8.h,),
        //what do you want
        WhatDoYouWant(),
ListView.separated(
  shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 6, itemBuilder: (BuildContext context, int index) {
  return TimeLineList();
    }, separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: 15.h,); },),
        SizedBox(height: 100.h,)
      ],
    );
  }
}
