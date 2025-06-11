// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:share_plus/share_plus.dart';

import '../../../../core/exports.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key? key,
    required this.avatar,
    required this.id,
    required this.byCaver,
  }) : super(key: key);
  final String avatar;
  final String byCaver;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        // خلفية الصورة

        SizedBox(
          height: getHeightSize(context) / 4.9,
          width: double.infinity,
          child: (byCaver != null)
              ? Image.network(
                  byCaver,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  ImageAssets.profileAppBar,
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
            onShareTap: () async {
              await SharePlus.instance.share(ShareParams(
                text: AppStrings.profilesShareLink + (id.toString() ?? ''),
                title: AppStrings.appName,
              ));
            },
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
          child: (avatar != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                )
              : SizedBox(
                  height: 48.h,
                  width: 48.h,
                  child: Image.asset(ImageAssets.profileImage),
                ),
        ),
      ],
    );
  }
}
