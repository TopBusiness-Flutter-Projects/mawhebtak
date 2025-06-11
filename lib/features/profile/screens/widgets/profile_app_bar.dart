import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_simple_appbar.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        // خلفية الصورة
        SizedBox(
          height: getHeightSize(context) / 4.9,
          width: getWidthSize(context),
          child: Image.asset(
            ImageAssets.profileAppBar,
            fit: BoxFit.cover,
          ),
        ),

        // AppBar
        Positioned(
          top: 20.h,
          left: 0,
          right: 0,
          child: CustomSimpleAppbar(
            isActionButton: true,
            actionIcon: AppIcons.shareIcon,
            // onShareTap: () async {
            //   await SharePlus.instance.share(ShareParams(
            //     text: AppStrings.profilesShareLink +
            //         (cubit.evntStore?.data.toString() ?? ''),
            //     title: AppStrings.appName,
            //   ));
            // },
            titleColor: AppColors.white,
            colorButton: AppColors.whiteSecond,
            title: ''.tr(),
            color: AppColors.transparent,
          ),
        ),

        // زر تغيير الخلفية
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteSecond.withOpacity(.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "change_cover".tr(),
                style: getRegularStyle(fontSize: 13.sp, color: AppColors.white),
              ),
            ),
          ),
        ),

        // صورة البروفايل في الأسفل بالشمال نصها طالع ونصها نازل
        Positioned(
          bottom: -24.h, // نصف الارتفاع عشان تنزل نص الصورة
          left: 16.w, // على الشمال
          child: SizedBox(
            height: 48.h,
            width: 48.h,
            child: Image.asset(ImageAssets.profileImage),
          ),
        ),
      ],
    );
  }
}
