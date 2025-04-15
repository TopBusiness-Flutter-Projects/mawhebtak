import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/get_size.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.title,
  });
 final  void Function()? onTap;
 final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
   //   borderRadius: BorderRadius.circular(getSize(context) / 12),
      child: Container(
height: 30.h,
       // width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(width: 1.0,color: AppColors.white)
        ),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp
          ),
        ),
      ),
    );
  }
}
