import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import '../../../../../core/exports.dart';

class LikeCommentShare extends StatefulWidget {
  final FeedsCubit feedsCubit;
  final String postId;

  const LikeCommentShare(
      {super.key, required this.feedsCubit, required this.postId});

  @override
  State<LikeCommentShare> createState() => _LikeCommentShareState();
}

class _LikeCommentShareState extends State<LikeCommentShare> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            widget.feedsCubit.addReaction(
              postId: widget.postId,
            );
            setState(() {});
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppIcons.likeIcon,
                  width: 20.sp,
                  color: widget.feedsCubit.postLikes[widget.postId] == true
                      ? AppColors.primary
                      : AppColors.grayDarkkk,
                ),
              ),
              Text(
                'like'.tr(),
                style: getRegularStyle(
                  fontSize: 18.sp,
                  color: AppColors.grayDate,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.commentIcon,
                width: 20.sp,
                color: AppColors.grayDarkkk,
              ),
            ),
            Text(
              'comment'.tr(),
              style: getRegularStyle(
                fontSize: 16.sp,
                color: AppColors.grayDate,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.shareIcon2,
                width: 20.sp,
                color: AppColors.grayDarkkk,
              ),
            ),
            Text(
              'share'.tr(),
              style: getRegularStyle(
                fontSize: 18.sp,
                color: AppColors.grayDate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
