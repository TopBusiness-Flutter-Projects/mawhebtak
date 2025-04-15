import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';
import '../../follow_button.dart';

class CustomTopTalentsList extends StatelessWidget {
  const CustomTopTalentsList({super.key,required this.isLeftPadding,required this.isRightPadding});
 final bool isLeftPadding;
 final bool isRightPadding;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsetsDirectional.only(start:isLeftPadding? 16.w:10.w,end: isRightPadding?16.w:0.0),
      child: Stack(
        alignment: Alignment.centerLeft, // Add alignment to the Stack
        children: [
          // Image container
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              height: 160.h,
              width: 198.w,
              child: Image.asset(
                ImageAssets.homeTestImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay with semi-transparent background for better text visibility
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(16.r),
          //   child: Container(
          //     height: 184.h,
          //     width: 198.w,
          //     color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
          //   ),
          // ),
          // Content to display over image
          SizedBox(
            width: 198.w, // Match image width
            height: 184.h, // Match image height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                SizedBox(height: 20.h),

                Text(
                  "Ahmed Mokhtar",
                  style: getSemiBoldStyle(color: AppColors.white, fontSize: 13.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Talent / Actor Expert",
                  style: getRegularStyle(color: AppColors.grayText, fontSize: 13.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),

                Text(
                  "20 K followers",
                  style: getMediumStyle(color: AppColors.grayText, fontSize: 13.sp),
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
                SizedBox(height: 5.h,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
