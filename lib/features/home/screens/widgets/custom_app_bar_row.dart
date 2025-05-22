import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomAppBarRow extends StatelessWidget {
  CustomAppBarRow(
      {super.key,
      this.color,
      this.backgroundNotification,
      this.isMore,
      this.colorSearchIcon,
      this.backgroundColorTextFieldSearch,
      this.colorTextFromSearchTextField});
  bool? isMore;
  Color? colorSearchIcon;
  Color? backgroundColorTextFieldSearch;
  Color? colorTextFromSearchTextField;
  Color? backgroundNotification;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color ?? AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: Image.asset(
                    ImageAssets.profileImage,
                  )),
              Expanded(
                child: Container(
                    height: 40.h,
                    width: 171.w,
                    decoration: BoxDecoration(
                      color:
                          backgroundColorTextFieldSearch ?? AppColors.blackLite,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    margin: const EdgeInsets.only(left: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("search".tr(),
                              style: getRegularStyle(
                                  fontSize: 13.sp,
                                  color: colorTextFromSearchTextField ??
                                      AppColors.white)),
                          const Spacer(),
                          SvgPicture.asset(
                            AppIcons.searchIcon,
                            color: colorSearchIcon ?? AppColors.white,
                          ),
                        ],
                      ),
                    )),
              ),
              10.w.horizontalSpace,
              isMore == true
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.videoScreenRoute);
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.videoIcon),
                          ),
                        ),
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.notificationRoute);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0.w),
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: backgroundNotification ?? AppColors.grayDark,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                          height: 21.h,
                          width: 18.w,
                          isMore == true
                              ? AppIcons.notificationWithBlueContainer
                              : AppIcons.notificationIcon),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
