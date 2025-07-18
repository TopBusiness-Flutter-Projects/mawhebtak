import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/utils/filter.dart';

import '../../config/routes/app_routes.dart';
import '../exports.dart';
import '../notification_services/notification_service.dart';

class CustomSimpleAppbar extends StatelessWidget {
  CustomSimpleAppbar({
    super.key,
    this.isSearchWidget,
    this.actionIcon,
    required this.title,
    this.isActionButton,
    this.colorButton,
    this.arrowColor,
    this.isDeepLink,
    this.onShareTap,
    this.color,
    this.filterType,
    this.categoryId,
    this.isWithShadow = false,
    this.titleColor,
    this.backActionOnTap,
  });
  final String title;
  final bool? isActionButton;
  final bool? isSearchWidget;
  final Color? color;
  final Color? titleColor;
  final Color? colorButton;
  final Color? arrowColor;
  final String? actionIcon;
  final bool? isWithShadow;
  final String? filterType;
  void Function()? backActionOnTap;
  bool? isDeepLink;
  void Function()? onShareTap;
  final String? categoryId;
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
              padding: EdgeInsets.only(top: 0.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: backActionOnTap ??
                        () {
                          if (isDeepLink == true) {
                            Navigator.pushReplacementNamed(
                                context, Routes.mainRoute);
                          } else if (isWithNotification == true) {
                            isWithNotification = false;
                            Navigator.pushReplacementNamed(
                                context, Routes.mainRoute);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 10.h, bottom: 5.h),
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
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                          shadows: isWithShadow == true
                              ? [
                                  Shadow(
                                      offset:
                                          const Offset(1, 1), // Shadow position
                                      blurRadius:
                                          3, // How soft the shadow should be
                                      color: Colors.black
                                          .withOpacity(0.7)), // Shadow color
                                ]
                              : [],
                          fontSize: 20.sp,
                          color: titleColor ?? AppColors.black),
                    ),
                  ),
                  if (isActionButton ?? false)
                    InkWell(
                      onTap: onShareTap ??
                          () {
                            showSortOptions(context, filterType ?? '',
                                categoryId: categoryId);
                          },
                      child: Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorButton ?? AppColors.grayLite,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.all(6.r),
                            child: SvgPicture.asset(
                                actionIcon ?? AppIcons.eventIcon),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
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
