import 'package:easy_localization/easy_localization.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_button.dart';
import 'follow_button.dart';

class UnderCustomRow extends StatelessWidget {
  const UnderCustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return         Positioned(
      bottom:140,
      // left: 30,
      child: SizedBox(
        width: getWidthSize(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.pushNamed(context, Routes.profileScreen);
                    },
                    child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset(ImageAssets.profileImage),
                    ),
                  ),
                  Text("Ahmed Mokhtar", style: getMediumStyle(color: AppColors.white,fontSize: 16.sp)),
                  Text("Talent / Actor Expert", style: getRegularStyle(color: AppColors.grayText,fontSize: 14.sp)),
               //   CustomButton(title: 'Follow', style: getMediumStyle(color: AppColors.white))
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 40.w,
                    child: Container(),
                  ),
                  Text("20 K followers", style: getMediumStyle(color: AppColors.white,fontSize: 14.sp)),
                  SizedBox(height: 5.h,),
                  // Text("Ahmed Mokhtar", style: getMediumStyle(color: AppColors.white)),
                  CustomContainerButton(title: "follow".tr(),)
                ],
              ),
            ),
          ],
        ),
      ),
    )
    ;
  }
}
