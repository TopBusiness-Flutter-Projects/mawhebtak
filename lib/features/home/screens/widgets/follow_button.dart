import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    this.onTap,
    required this.title,
    this.color,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.width,
    this.borderColor,
    this.textColor,
    this.padding,
  });
  final void Function()? onTap;
  final String title;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      //   borderRadius: BorderRadius.circular(getSize(context) / 12),
      child: Container(
        height: height ?? 40.h,
        width: width,
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppColors.transparent),
          color: color ?? AppColors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: AutoSizeText(
          title.tr(),
          style: TextStyle(
              color: textColor ?? AppColors.white,
              fontFamily: AppStrings.fontFamily,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 18.sp),
        ),
      ),
    );
  }
}
