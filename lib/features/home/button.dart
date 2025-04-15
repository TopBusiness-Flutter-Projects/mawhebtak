import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/get_size.dart';

class CustomButtonnnnnnnn extends StatelessWidget {
  const CustomButtonnnnnnnn({
    super.key,
    this.onTap,
    required this.title,
    this.color,
    this.height,
    this.textColor,
  });
  final  void Function()? onTap;
  final String title;
  final Color ?textColor;
  final double ?height;
  final Color ?color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      //   borderRadius: BorderRadius.circular(getSize(context) / 12),
      child: Container(
        height: height??30.h,
        // width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        decoration: BoxDecoration(
            color: color??AppColors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.0,color: AppColors.white)
        ),
        child: Text(
          title,
          style: TextStyle(
              color:textColor ??AppColors.white,
              fontFamily: AppStrings.fontFamily,
              fontWeight:FontWeight.w400,
              fontSize: 14.sp
          ),
        ),
      ),
    );
  }
}
