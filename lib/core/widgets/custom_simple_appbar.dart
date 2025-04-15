
import 'package:flutter_svg/svg.dart';

import '../exports.dart';

class CustomSimpleAppbar extends StatelessWidget {
  const CustomSimpleAppbar({super.key, required this.title, this.isEventScreen});
final String title;
final bool ?isEventScreen;
  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: getSize(context)/6,
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
          color: AppColors.grayLite,
          blurStyle: BlurStyle.inner,
          offset: const Offset(0, 1),
        )
      ]),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:  EdgeInsets.only(left: 10.w,right: 10.w),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.grayLite,
                    borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.only(left: 5.w, right: 5.w,bottom: 5.h,top: 5.h),
                child:  Padding(
                  padding:  EdgeInsets.all(6.r),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.darkGray,
                    size: 16.sp,),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(fontSize: 16.sp, color: AppColors.black),
            ),
          ),
          if(isEventScreen??false)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppIcons.eventIcon),
            )        ],
      ),
    );
  }
}
