import 'dart:io';

import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/exports.dart';
import '../../../main_screen/cubit/cubit.dart';

class ProfileAppBar extends StatelessWidget {
  ProfileAppBar({
    Key? key,
    required this.avatar,
    required this.id,
    this.byCaver,
    required this.isEdit,
  }) : super(key: key);
  final String avatar;

  String? byCaver;
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
                    ? Image.network(
                        byCaver ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(ImageAssets.profileAppBar),
                      )
                    : Image.asset(ImageAssets.profileImage),
          ),
          // AppBar
          Positioned(
            top: 20.h,
            left: 0,
            right: 0,
            child: CustomSimpleAppbar(
              isActionButton: true,
              backActionOnTap: () {
                context.read<MainCubit>().getUserData();
                Navigator.pop(context);
              },
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
                GestureDetector(
                  onTap: () {
                    if (isEdit) {
                      context
                          .read<ProfileCubit>()
                          .pickSingleImage(type: 'avatar');
                    }
                  },
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: cubit.avatarImage != null
                        ? FileImage(File(cubit.avatarImage!.path))
                        : (avatar.isNotEmpty && avatar.startsWith('http'))
                            ? NetworkImage(avatar)
                            : const AssetImage(ImageAssets.profileImage),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
