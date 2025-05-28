import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/routes/app_routes.dart';
import '../exports.dart';
import '../notification_services/notification_service.dart';

class CustomSimpleAppbar extends StatelessWidget {
  const CustomSimpleAppbar(
      {super.key,
      this.isSearchWidget,
      this.actionIcon,
      required this.title,
      this.isActionButton,
      this.colorButton,
      this.arrowColor,
      this.color,
      this.titleColor});
  final String title;
  final bool? isActionButton;
  final bool? isSearchWidget;
  final Color? color;
  final Color? titleColor;
  final Color? colorButton;
  final Color? arrowColor;
  final String? actionIcon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: getSize(context)/7,
        decoration: BoxDecoration(color: color ?? AppColors.white, boxShadow: [
          BoxShadow(
            color: color ?? AppColors.grayLite,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 1),
          )
        ]),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isWithNotification == true) {
                        isWithNotification = false;
                        Navigator.pushReplacementNamed(
                            context, Routes.mainRoute);
                      }
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorButton ?? AppColors.grayLite,
                            borderRadius: BorderRadius.circular(8.r)),
                        padding: EdgeInsets.only(
                            left: 5.w, right: 5.w, bottom: 5.h, top: 5.h),
                        child: Padding(
                          padding: EdgeInsets.all(6.r),
                          child: Icon(
                            Icons.arrow_back,
                            color: arrowColor ?? AppColors.darkGray,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(shadows: [
                        Shadow(
                            offset: const Offset(1, 1), // Shadow position
                            blurRadius: 3, // How soft the shadow should be
                            color:
                                Colors.black.withOpacity(0.7)), // Shadow color
                      ], fontSize: 20.sp, color: titleColor ?? AppColors.black),
                    ),
                  ),
                  if (isActionButton ?? false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(actionIcon ?? AppIcons.eventIcon),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            if (isSearchWidget ?? false)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    height: 40.h,
                    //   width: 171.w,
                    decoration: BoxDecoration(
                      color: AppColors.grayLite2,
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
                                  color: AppColors.grayDarkkk)),
                          const Spacer(),
                          SvgPicture.asset(
                            AppIcons.searchIcon,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
