import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/see_more_text.dart';

import '../../../../../core/exports.dart';
import 'like_comment_share.dart';

class TimeLineList extends StatelessWidget {
  const TimeLineList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      //profile info

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset(ImageAssets.profileImage),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Ahmed Mokhtar'.tr(),
                      style: getMediumStyle(fontSize: 16.sp),
                    ),
                    AutoSizeText(
                      'Talent / Actor Expert'.tr(),
                      style: getRegularStyle(
                        fontSize: 14.sp,
                        color: AppColors.grayLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(AppIcons.settingIcon),
          ],
        ),
      ),
      //profile desc
      Padding(
        padding:  EdgeInsets.only(left: 10.0.w),
        child: ExpandableTextWidget(text: 'Hi show my latest scenes with an amazing team Let’s start our work  ',),
        ),

      SizedBox(height: 5.h,),
      //photo
      SizedBox(
        width: double.infinity,
        height: getHeightSize(context) / 3.7,
        child: Image.asset(
          ImageAssets.tasweerPhoto,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(height: 5.h),
      //like and comments
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppIcons.likeIcon),
              ),
              Text(
                '200',
                style: getSemiBoldStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "10"+" "+'comment'.tr(),
              style: getRegularStyle(
                fontSize: 14.sp,
                color: AppColors.grayDate,
              ),
            ),
          ),
        ],
      ),
      //
      SizedBox(height: 3.h),
      Container(
        height: 2.h,
        color: AppColors.grayLite,
      ),
      //like and comment and share
      LikeCommentShare(),
    ],);
  }
}
