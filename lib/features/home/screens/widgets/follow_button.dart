import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/get_size.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    this.onTap,
    required this.title,
    this.color,
    this.height,
    this.width,
    this.borderColor,
    this.textColor,
  });
  final  void Function()? onTap;
  final String title;
  final Color ?textColor;
  final Color ?borderColor;
  final double ?height;
  final double ?width;
  final Color ?color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      //   borderRadius: BorderRadius.circular(getSize(context) / 12),
      child: Container(
        height: height ?? 40.h,
         width: width ?? null,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(
            color: color??AppColors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.0,color: borderColor??AppColors.white)
        ),
        child: AutoSizeText(
          title.tr(),
          style: TextStyle(
              color:textColor ??AppColors.white,
              fontFamily: AppStrings.fontFamily,
              fontWeight:FontWeight.w400,
              fontSize: 20.sp
          ),
        ),
      ),
    );
  }
}
