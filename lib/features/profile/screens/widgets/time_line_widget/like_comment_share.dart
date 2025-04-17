import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/exports.dart';

class LikeCommentShare extends StatelessWidget {
  const LikeCommentShare({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.likeIcon,
                color: AppColors.grayDarkkk,
              ),
            ),
            Text(
              'like'.tr(),
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
