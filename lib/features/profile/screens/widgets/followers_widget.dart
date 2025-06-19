import 'package:auto_size_text/auto_size_text.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import '../../../../core/widgets/custom_container_with_shadow.dart';
import '../../../home/screens/widgets/follow_button.dart';

class FollowersWidget extends StatelessWidget {
  FollowersWidget({super.key, this.index});
  int? index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopTalentsCubit,TopTalentsState>(
      builder: (context,state) {
        var topTalentCubit = context.read<TopTalentsCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomContainerWithShadow(
            reduis: 8.r,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: Image.asset(ImageAssets.profileImage),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                                topTalentCubit.followerAndFollowingModel?.data?[index!].name ??
                                    "",
                                style: getMediumStyle(fontSize: 14.sp)),
                            AutoSizeText(
                              topTalentCubit.followerAndFollowingModel?.data?[index!].headline ??
                                  "",
                              style: getRegularStyle(
                                  fontSize: 14.sp, color: AppColors.grayLight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  CustomContainerButton(
                    fontSize: 14.sp,
                    onTap: () async {
                      final user = await Preferences.instance.getUserModel();
                      if (user.data?.token == null) {
                        checkLogin(context);
                      } else {
                        topTalentCubit.followAndUnFollow(
                            index: index,
                            context,
                            item: topTalentCubit.topTalents?.data?[index!],
                            followedId: topTalentCubit
                                .followerAndFollowingModel?.data?[index!].id
                                .toString() ??
                                "");
                      }
                    },
                    height: 35.h,
                    title:  topTalentCubit.followerAndFollowingModel?.data?[index!].isIFollow ==
                        true
                        ? "un_follow".tr()
                        : "follow".tr(),
                    borderColor:
                    topTalentCubit.followerAndFollowingModel?.data?[index!].isIFollow ==
                        true
                        ? AppColors.white
                        : AppColors.primary,
                    color:  topTalentCubit.followerAndFollowingModel?.data?[index!].isIFollow ==
                        true
                        ? AppColors.primary
                        : AppColors.white,
                    textColor:
                    topTalentCubit.followerAndFollowingModel?.data?[index!].isIFollow ==
                        true
                        ? AppColors.white
                        : AppColors.primary,

                  ),
                ],
              ),
            ),
          ),
        );
          },
        );

  }
}
