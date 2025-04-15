import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomAppBarRow extends StatelessWidget {
  const CustomAppBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 40.h,width: 40.w,
              child: Image.asset(ImageAssets.profileImage,)),


          Container(
              height: 40.h,
              width: 171.w,

              decoration: BoxDecoration(
                color: AppColors.blackLite,
                borderRadius: BorderRadius.circular(8.r),
              ),
              margin: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "search".tr(),
                        style: getRegularStyle(
                            fontSize: 13.sp,
                            color: AppColors.white   )),
                    Spacer(),

                    SvgPicture.asset(AppIcons.searchIcon),


                  ],
                ),
              )),


          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.videoScreenRoute);
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Container(height: 40.h,width: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.r),),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppIcons.videoIcon),
                ),),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.notificationScreen);
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 1.0.w),
              child: Container(height: 40.h,width: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.grayDark,
                  borderRadius: BorderRadius.circular(8.r),),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                      height: 21.h,width: 18.w,
                      AppIcons.notificationIcon),
                ),),
            ),
          ),
        ]);
  }
}
