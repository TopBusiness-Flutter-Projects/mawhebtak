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
    required this.isEdit,
  }) : super(key: key);
  final String avatar;
  final String byCaver;
  final String id;
  final bool isEdit;
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
                  : (byCaver != null)
                      ?Image.network(byCaver,fit: BoxFit.cover,)
                      : Image.asset(ImageAssets.profileImage)),

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

          if (isEdit == true)
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

          Positioned(
            bottom: -24.h,
            left: 16.w,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundImage: cubit.avatarImage != null
                      ? FileImage(File(cubit.avatarImage!.path))
                      : (avatar != null && avatar.isNotEmpty
                          ? NetworkImage(avatar) as ImageProvider
                          : const AssetImage(ImageAssets.profileImage)),
                ),

                if (isEdit == true)
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ProfileCubit>()
                          .pickSingleImage(type: 'avatar');
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
