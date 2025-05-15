import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/see_more_text.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

import '../../../../../core/exports.dart';
import 'like_comment_share.dart';

class TimeLineList extends StatelessWidget {
  const TimeLineList({super.key,  this.feeds, this.feedsCubit, required this.postId});
  final  PostsModelData? feeds;
  final FeedsCubit ? feedsCubit;
  final String postId;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding:  EdgeInsets.only(bottom: 10.h,top: 10.h,right: 10.w,left: 10.w),
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
                     feeds?.user?.name??"",
                      style: getMediumStyle(fontSize: 16.sp),
                    ),
                    AutoSizeText(
                      feeds?.user?.headline ?? "Telent / Actor Expert",
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
        child:  ExpandableTextWidget(text:   feeds?.body ?? "",),
        ),
      SizedBox(height: 5.h,),
      //photo
        feeds?.user?.image == null ?
      SizedBox(
        width: double.infinity,
        height: getHeightSize(context) / 3.7,
        child: Image.asset(
          ImageAssets.tasweerPhoto,
          fit: BoxFit.cover,
        ),
      ):
        SizedBox(
          width: double.infinity,
          height: getHeightSize(context) / 3.7,
          child: Image.network(
            feeds?.user?.image ?? "",
            fit: BoxFit.cover,
          ),
        ),
      SizedBox(height: 5.h),
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
               feeds?.reactionCount.toString() ?? "0",
                style: getSemiBoldStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${feeds?.commentCount.toString()}  ${'comment'.tr()}",
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
       LikeCommentShare(

        feedsCubit: feedsCubit!,
         postId: postId,
      ),
        Container(color: AppColors.grayLite,height: 10.h,)
    ],);
  }
}
