import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/app_routes.dart';
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
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.gigsDetailsScreen);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Routes.gigsDetailsScreen);
                },
                  child: Image.asset(ImageAssets.testBallImage)),

              Positioned(
                  top:10.h,
                  right :15.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.grayLite,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.more_vert_sharp,color: AppColors.grayDark,),
                  )),
            ],
          ),
          5.h.verticalSpace,
          Padding(
            padding:  EdgeInsets.only(left: 15.0.w,right: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Text("Get Your Digital Printing Images",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),),
              5.h.verticalSpace,
              Text("Hi show my latest scenes with an amazing team Let’s start our work",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.blackLite,
                ),),
              5.h.verticalSpace,
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
            ],),
          ),
      10.verticalSpace,
         if(isWithButton??false)
          Padding(
            padding:  EdgeInsets.only(bottom: 10.h),
            child: const CustomButton(title: "Request this gigs"),
          ),

        ],
      ),
    );
  }
}
