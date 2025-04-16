import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';

class GoogleAndFacebookWidget extends StatelessWidget {
  const GoogleAndFacebookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.sp),
              border: Border.all(color: AppColors.grayLite),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 10.h,
                  bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.facebookIcon),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "facebook".tr(),
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.sp),
              border: Border.all(color: AppColors.grayLite),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 10.h,
                  bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.googleIcon),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "google".tr(),
                    style: TextStyle(
                        color:
                        AppColors.darkGray.withOpacity(0.8),
                        fontSize: 15.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
