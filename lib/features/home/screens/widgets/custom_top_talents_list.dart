import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../core/exports.dart';
import 'follow_button.dart';

class CustomTopTalentsList extends StatelessWidget {
  const CustomTopTalentsList(
      {
      super.key,
      required this.isLeftPadding,
      required this.isRightPadding, required this.topTalentsData,  this.topTalentsCubit});
  final bool isLeftPadding;
  final bool isRightPadding;
  final TopTalent? topTalentsData;
  final TopTalentsCubit? topTalentsCubit;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: isLeftPadding ? 16.w : 10.w,
          end: isRightPadding ? 16.w : 0.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          (topTalentsData?.image == null) ?
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              child: Image.asset(
                ImageAssets.homeTestImage,
                fit: BoxFit.cover,
              ),
            ),
          ):
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                SizedBox(
                  height: 160.h,
                  width: 198.w,
                  child: Image.network(
                    topTalentsData?.image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                // Now inside the image container
                Positioned(
                  top: 6.h,
                  right: 8.w,
                  child: InkWell(
                      onTap: () {
                        topTalentsCubit?.hideTopTalent(unwantedUserId: topTalentsData?.id.toString() ?? "0");
                      },
                      child: SvgPicture.asset(AppIcons.removeIcon)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 198.w,
            height: 160.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  topTalentsData?.name ?? "",
                  style: getSemiBoldStyle(
                      color: AppColors.white, fontSize: 13.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  topTalentsData?.headline??  "Talent / Actor Expert",
                  style: getRegularStyle(
                      color: AppColors.grayText, fontSize: 13.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  "${topTalentsData?.followersCount ?? 20}  followers",
                  style: getMediumStyle(
                      color: AppColors.grayText, fontSize: 13.sp),
                  textAlign: TextAlign.center,
                ),
                5.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: CustomContainerButton(
                    title: "follow".tr(),
                    color: AppColors.white,
                    textColor: AppColors.primary,
                    width: 129.w,
                  ),
                ),
              5.h.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
