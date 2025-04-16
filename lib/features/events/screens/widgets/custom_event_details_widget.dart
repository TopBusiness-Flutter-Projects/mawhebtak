import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_simple_appbar.dart';
import '../../../home/screens/widgets/follow_button.dart';

class CustomEventDetailsWidget extends StatelessWidget {
  const CustomEventDetailsWidget({super.key,this.onTap,this.isSecondEventDetails});
  final void Function()? onTap;
  final bool ?isSecondEventDetails;
  @override
  Widget build(BuildContext context) {
    return     Stack(
      alignment: Alignment.centerLeft, // Add alignment to the Stack
      children: [
        // Image container
        ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.r),bottomRight: Radius.circular(8.r)),
          child: SizedBox(
            height: 220.h,
            width:getWidthSize(context),
            child: Image.asset(
              ImageAssets.homeTestImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Move AppBar to the top
        // SizedBox(height: 5.h,)
        Positioned(
          top: 15.h,
          left: 0,
          right: 0,
          child: CustomSimpleAppbar(
            titleColor: AppColors.white,
            colorButton: AppColors.whiteSecond,
            title: 'events_details'.tr(),
            color: AppColors.transparent,
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
          width:getWidthSize(context)/.9, // Match image width
          // height: 184.h, // Match image height
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.start, // Center horizontally
              children: [
                SizedBox(height: 60.h),

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
                    Text(
                      "500 L.E",
                      style: getSemiBoldStyle(fontSize: 17.sp,color: AppColors.green),
                    ),

                  ],
                ),

                SizedBox(height: 8.h,),
               if(isSecondEventDetails??false) ...[
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Flexible(child: Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 7.0.w),
                       child: CustomContainerButton(title:isSecondEventDetails??false?"cancel_this_event".tr(): "follow_event".tr(),onTap:onTap,borderColor: isSecondEventDetails??false?AppColors.red:AppColors.white,textColor:isSecondEventDetails??false?AppColors.red:AppColors.white ,),
                     )),
                     SizedBox(width:getWidthSize(context)/50),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       child: SvgPicture.asset(AppIcons.settingIcon),
                     )
                   ],
                 ),
                ]

else...[
    CustomContainerButton(title:isSecondEventDetails??false?"cancel_this_event".tr(): "follow_event".tr(),onTap:onTap,borderColor: isSecondEventDetails??false?AppColors.red:AppColors.white,textColor:isSecondEventDetails??false?AppColors.red:AppColors.white ,),
    ]
              ],
            ),
          ),
        ),

      ],
    );
  }
}
