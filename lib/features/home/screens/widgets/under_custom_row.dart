import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/check_login.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../core/exports.dart';
import '../../../events/screens/details_event_screen.dart';
import 'follow_button.dart';

class UnderCustomRow extends StatelessWidget {
  const UnderCustomRow({super.key, this.userTalent});
  final TopTalent? userTalent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidthSize(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.profileRoute,
                        arguments: DeepLinkDataModel(
                            id: userTalent?.id.toString() ?? '',
                            isDeepLink: false),
                      );
                    },
                    child: userTalent?.image == null
                        ? SizedBox(
                            child: Image.asset(ImageAssets.profileImage),
                          )
                        : CircleAvatar(
                            radius: 30.r,
                            backgroundImage: userTalent?.image != null &&
                                    userTalent!.image!.isNotEmpty
                                ? NetworkImage(userTalent!.image!)
                                : null,
                            child: userTalent?.image == null ||
                                    userTalent!.image!.isEmpty
                                ? const Icon(Icons.person)
                                : null,
                          )),
                Text(userTalent?.name ?? "",
                    style: getMediumStyle(
                        color: AppColors.white, fontSize: 16.sp)),
                Text(userTalent?.headline ?? "",
                    style: getRegularStyle(
                        color: AppColors.grayText, fontSize: 14.sp)),
                //   CustomButton(title: 'Follow', style: getMediumStyle(color: AppColors.white))
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30.h,
                  width: 40.w,
                  child: Container(),
                ),
                Text("${userTalent?.followersCount ?? 0}  followers",
                    style: getMediumStyle(
                        color: AppColors.white, fontSize: 14.sp)),
                SizedBox(
                  height: 5.h,
                ),
                BlocBuilder<TopTalentsCubit,TopTalentsState>(
                  builder: (context,state) {
                    var topTalentsCubit = context.read<TopTalentsCubit>();
                    return CustomContainerButton(
                      onTap: () async {
                        final user = await Preferences.instance.getUserModel();
                        if (user.data?.token == null) {
                          checkLogin(context);
                        } else {
                          topTalentsCubit.followAndUnFollow(
                            context,
                            item: userTalent,
                            followedId: userTalent?.id.toString() ?? "",
                          );
                        }
                      },
                      height: 30.h,
                      title: userTalent?.isIFollow == true
                          ? "un_follow".tr()
                          : "follow".tr(),
                      color:userTalent?.isIFollow == true
                          ? AppColors.primary
                          : AppColors.white,
                      textColor:userTalent?.isIFollow == true
                          ? Colors.white
                          : AppColors.primary,
                      width: 120.w,
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
