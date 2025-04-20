import 'package:flutter_svg/svg.dart';

import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_button.dart';

class GigsWidget extends StatelessWidget {
  GigsWidget({

    super.key,
    this.isWithButton,
  });
  bool? isWithButton = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(ImageAssets.testBallImage),

            Positioned(
                top:10,
                right :10,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.grayLite,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.more_vert_sharp,color: AppColors.grayDark,),
                )),
          ],
        ),
        10.h.verticalSpace,
        Text("Get Your Digital Printing Images",style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),),
        10.h.verticalSpace,
        Text("Hi show my latest scenes with an amazing team Let’s start our work",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.blackLite,
          ),),
        10.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppIcons.locationIcon),
                5.w.horizontalSpace,
                Text("Cairo, Nasr City",style: TextStyle(color: AppColors.grayDarkkk,fontSize: 14.sp,fontWeight: FontWeight.w400),)
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(AppIcons.dollar),
                5.w.horizontalSpace,
                Text("200 L.E",style: TextStyle(color: AppColors.primary,fontSize: 14.sp,fontWeight: FontWeight.w400),)
              ],
            ),
          ],),
        (isWithButton == true) ?
        Padding(
          padding:  EdgeInsets.only(bottom: 10.h),
          child: const CustomButton(title: "Request this gigs"),
        ):SizedBox(),

      ],
    );
  }
}
