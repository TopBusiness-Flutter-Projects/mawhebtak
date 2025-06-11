import 'package:easy_localization/easy_localization.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class InfoForFollowers extends StatelessWidget {
  const InfoForFollowers({super.key, required this.followersCount, required this.followingCount, required this.postsCount});

  final String followersCount;
  final String followingCount;
  final String postsCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              followersCount,
              style: getRegularStyle(fontSize: 14.sp, color: AppColors.green),
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.followersScreen);
                },
                child: Text(
                  "followers".tr(),
                  style: getUnderLine(fontSize: 14.sp, color: AppColors.green),
                ))
          ],
        ),
        Column(
          children: [
            Text(
              followingCount,
              style: getRegularStyle(fontSize: 14.sp, color: AppColors.green),
            ),
            Text(
              "following".tr(),
              style: getUnderLine(fontSize: 14.sp, color: AppColors.green),
            )
          ],
        ),
        Column(
          children: [
            Text(
              postsCount,
              style: getRegularStyle(fontSize: 14.sp, color: AppColors.green),
            ),
            Text(
              "post".tr(),
              style: getUnderLine(fontSize: 14.sp, color: AppColors.green),
            )
          ],
        )
      ],
    );
  }
}
