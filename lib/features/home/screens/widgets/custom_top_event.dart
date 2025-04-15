import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/exports.dart';
import '../../follow_button.dart';

class CustomTopEventList extends StatelessWidget {
  const CustomTopEventList({super.key,required this.isLeftPadding,required this.isRightPadding});
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
              height: 200.h,
              width: 287.w,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Center vertically
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        SvgPicture.asset(AppIcons.calenderIcon),
                        Text("16 june 2022",style: getRegularStyle(fontSize: 13.sp),),
                      ],),
                      Spacer(),
                      Text("16 june 2022",style: getRegularStyle(fontSize: 13.sp),),

                      // CustomContainerButton(
                      //   title: "follow".tr(),
                      //   color: AppColors.white,
                      //   textColor: AppColors.primary,
                      //   width: 100.w,
                      // ),
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
