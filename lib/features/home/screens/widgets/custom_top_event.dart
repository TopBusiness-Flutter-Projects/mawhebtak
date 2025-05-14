import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import 'follow_button.dart';

class CustomTopEventList extends StatelessWidget {
  const CustomTopEventList(
      {super.key,
      this.isLeftPadding,
      this.isRightPadding,
      this.isAll,
      required this.topEvent});
  final bool? isLeftPadding;
  final bool? isRightPadding;
  final bool? isAll;
  final EventAndGigsModel? topEvent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: isLeftPadding ?? false ? 16.w : 8.w,
          end: isRightPadding ?? false ? 16.w : 0.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          topEvent?.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    height: 200.h,
                    width: isAll ?? false ? getWidthSize(context) / .9 : 287.w,
                    child: Image.network(
                      topEvent?.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    width: isAll ?? false ? getWidthSize(context) / .9 : 287.w,
                    child: Image.asset(
                      ImageAssets.homeTestImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: isAll ?? false
                    ? getWidthSize(context) / .9
                    : 287.w, // Match image width
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Center vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Center horizontally
                    children: [
                      Text(
                        topEvent?.title ?? "",
                        style: getMediumStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        topEvent?.description ?? "",
                        maxLines: 2,
                        style: getRegularStyle(
                            color: AppColors.grayText, fontSize: 12.sp),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.calenderIcon),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Text(
                                    topEvent?.from ?? "",
                                    style: getRegularStyle(
                                        fontSize: 13.sp,
                                        color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomContainerButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.detailsEventScreen);
                            },
                            title: "details".tr(),
                            color: AppColors.transparent,
                            textColor: isAll ?? false
                                ? AppColors.lbny
                                : AppColors.primary,
                            borderColor: isAll ?? false
                                ? AppColors.lbny
                                : AppColors.primary,
                            width: 100.w,
                          ),
                        ],
                      ),
                      5.h.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
