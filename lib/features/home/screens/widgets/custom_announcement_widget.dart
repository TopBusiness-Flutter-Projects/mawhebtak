import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';

import '../../../../core/exports.dart';

class CustomAnnouncementWidget extends StatelessWidget {
  const CustomAnnouncementWidget({
    super.key,
    required this.isLeftPadding,
    required this.isRightPadding,
  });

  final bool isLeftPadding;
  final bool isRightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: isLeftPadding ? 16.w : 10.w,
        end: isRightPadding ? 16.w : 0.0,
      ),
      child: CustomContainerWithShadow(
width: 299.w,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: Image.asset(ImageAssets.profileImage),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("Ahmed Mokhtar", style: getMediumStyle(fontSize: 16.sp)),
                      AutoSizeText(
                        "Talent / Actor Expert",
                        style: getRegularStyle(fontSize: 14.sp, color: AppColors.grayLight),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: SizedBox(
                  width: 290.w,
                  height: 137.w,
                  child: Image.asset(
                    ImageAssets.tasweerPhoto,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              AutoSizeText("Talent / Actor Expert", style: getSemiBoldStyle(fontSize: 14.sp, color: AppColors.grayDark)),
              AutoSizeText("Hi show my latest scenes with an amazing team Let’s start our work", style: getRegularStyle(fontSize: 14.sp, color: AppColors.grayDark)),
              SizedBox(height: 5.h,),
              Row(children: [
                Expanded(
                  child: Row(children: [
                    SvgPicture.asset(AppIcons.locationIcon),
                    SizedBox(width: 3.w,),
                    Expanded(child: Text("Cairo, Nasr City",style: getRegularStyle(color: AppColors.grayLight,fontSize: 14.sp,),))
                  ],),
                ),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.dollarSign),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText("200 L.E",style: getRegularStyle(fontSize: 14.sp,color: AppColors.blueLight),),
                  )
                ],
              )
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
