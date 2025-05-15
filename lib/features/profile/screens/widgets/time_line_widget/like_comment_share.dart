import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

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
          onTap: () async {
            await widget.feedsCubit.addReaction(
              postId: widget.postId,
              reaction: "like",
            );
            setState(() {}); // لإعادة بناء الواجهة بعد تغيير البيانات
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppIcons.likeIcon,
                  color: widget.feedsCubit.post?.isLiked == true
                      ? AppColors.primary
                      : AppColors.grayDarkkk,
                ),
              ),
              Text(
                widget.feedsCubit.post?.isLiked == true
                    ? 'like'.tr()
                    : 'disLike'.tr(),
                style: getRegularStyle(
                  fontSize: 14.sp,
                  color: AppColors.grayDate,
                ),
              ),
            ],
          ),
        ),
        // باقي الأزرار
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.commentIcon,
                color: AppColors.grayDarkkk,
              ),
            ),
            Text(
              'comment'.tr(),
              style: getRegularStyle(
                fontSize: 14.sp,
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
                color: AppColors.grayDarkkk,
              ),
            ),
            Text(
              'share'.tr(),
              style: getRegularStyle(
                fontSize: 14.sp,
                color: AppColors.grayDate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
