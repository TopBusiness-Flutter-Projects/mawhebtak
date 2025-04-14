import 'package:flutter_svg/svg.dart';

import '../../../../core/exports.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(height: 40.h,width: 40.w,
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(8.r),),
              child: SvgPicture.asset(AppIcons.notificationIcon),),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(height: 40.h,width: 40.w,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),),
              child: SvgPicture.asset(AppIcons.videoIcon),),
          ),

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
                    SvgPicture.asset(AppIcons.searchIcon),
                    Spacer(),
                    Text(
                        "Search",
                        style: getBoldStyle(

                            color: AppColors.white   )),

                  ],
                ),
              )),
          SizedBox(
              height: 40.h,width: 40.w,
              child: Image.asset(ImageAssets.profileImage,)),
        ]);
  }
}
