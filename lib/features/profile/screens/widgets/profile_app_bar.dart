import 'dart:io';

import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
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
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      var cubit = context.read<ProfileCubit>();
      return Stack(
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: getHeightSize(context) / 4.9,
            width: double.infinity,
            child: (cubit.coverImage != null)
                ? Image.file(
                    File(cubit.coverImage!.path),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                :
             (byCaver != null)   ?
            CircleAvatar(
              backgroundImage: NetworkImage(byCaver),
            ):
             Image.asset(ImageAssets.profileImage)
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
            child: GestureDetector(
              onTap: () {
                context.read<ProfileCubit>().pickSingleImage(type: 'cover');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteSecond.withOpacity(.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "change_cover".tr(),
                    style: getRegularStyle(
                        fontSize: 13.sp, color: AppColors.white),
                  ),
                ),
              ),
            ),
          ),

          // صورة البروفايل في الأسفل بالشمال نصها طالع ونصها نازل
          Positioned(
            bottom: -24.h,
            left: 16.w,
            child: (avatar != null)
                ? GestureDetector(
                    onTap: () {
                      context
                          .read<ProfileCubit>()
                          .pickSingleImage(type: 'avatar');
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      context
                          .read<ProfileCubit>()
                          .pickSingleImage(type: 'avatar');
                    },
                    child: SizedBox(
                      height: 55.h,
                      width: 55.h,
                      child: Image.asset(ImageAssets.profileImage),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
