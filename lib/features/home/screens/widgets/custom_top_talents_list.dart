import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../core/exports.dart';
import 'follow_button.dart';

class CustomTopTalentsList extends StatelessWidget {
  const CustomTopTalentsList(
      {super.key, required this.topTalentsData, this.topTalentsCubit});

  final TopTalent? topTalentsData;
  final TopTalentsCubit? topTalentsCubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, end: 5.w),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          (topTalentsData?.image == null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    child: Image.asset(
                      ImageAssets.homeTestImage,
                      fit: BoxFit.cover,
                      height: 160.h,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: 198.w,
                        child: Image.network(
                          topTalentsData?.image ?? "",
                          fit: BoxFit.cover,
                          height: 200.h,
                          width: 198.w,
                        ),
                      ),
                      // Now inside the image container
                      Positioned(
                        top: 6.h,
                        right: 8.w,
                        child: GestureDetector(
                          onTap: () async {
                            print("Tapped");
                            await topTalentsCubit?.hideTopTalent(
                                unwantedUserId:
                                    topTalentsData?.id.toString() ?? "0");
                          },
                          child: SvgPicture.asset(AppIcons.removeIcon),
                        ),
                      ),
                    ],
                  ),
                ),
          Positioned(
            bottom: 10.h,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    topTalentsData?.name ?? "",
                    maxLines: 1,
                    style: getSemiBoldStyle(
                        color: AppColors.white, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    topTalentsData?.headline ?? "Talent / Actor Expert",
                    maxLines: 1,
                    style: getRegularStyle(
                        color: AppColors.grayText, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                  5.verticalSpace,
                  Text(
                    "${topTalentsData?.followersCount ?? 20}  followers",
                    maxLines: 1,
                    style: getMediumStyle(
                        color: AppColors.grayText, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: CustomContainerButton(
                      height: 40.h,
                      title: "follow".tr(),
                      color: AppColors.white,
                      textColor: AppColors.primary,
                      width: 129.w,
                    ),
                  ),
                  10.h.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
