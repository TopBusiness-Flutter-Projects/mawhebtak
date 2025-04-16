import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import 'follow_button.dart';

class CustomTopEventList extends StatelessWidget {
  const CustomTopEventList({super.key, this.isLeftPadding, this.isRightPadding,this.isAll});
  final bool ?isLeftPadding;
  final bool ?isRightPadding;
  final bool ?isAll;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsetsDirectional.only(start:isLeftPadding??false? 16.w:8.w,end: isRightPadding??false?16.w:0.0),
      child: Stack(
        alignment: Alignment.centerLeft, // Add alignment to the Stack
        children: [
          // Image container
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 200.h,
              width: isAll??false?getWidthSize(context)/.9:287.w,
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
             width:isAll??false?getWidthSize(context)/.9: 287.w, // Match image width
            // height: 184.h, // Match image height
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Center vertically
                crossAxisAlignment: CrossAxisAlignment.start, // Center horizontally
                children: [
                  SizedBox(height: 80),

                  Text(

                    "Ahmed Mokhtar",
                    style: getMediumStyle(color: AppColors.white, fontSize: 14.sp,),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "We can meet with best artists in egypt to can match rqueriments anywhere",
                    style: getRegularStyle(color: AppColors.grayText, fontSize: 12.sp),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10.h),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                "16 june 2022",
                                style: getRegularStyle(fontSize: 13.sp,color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   "16 june 2022",
                      //   style: getRegularStyle(fontSize: 13.sp),
                      // ),
                      CustomContainerButton(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.detailsEventScreen);
                        },
                        title: "details".tr(),
                        color: AppColors.transparent,
                        textColor: isAll??false?AppColors.lbny:AppColors.primary,
                        borderColor: isAll??false?AppColors.lbny:AppColors.primary,
                        width: 100.w,
                      ),
                    ],
                  ),

                  SizedBox(height: 5.h,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
