import 'package:mawhebtak/core/exports.dart';

TextStyle _getTextStyle(
    {required double fontSize,
    double? fontHeight,
    required FontWeight fontWeight,
    required Color color}) {
  return TextStyle(
      height: fontHeight,
      fontSize: fontSize,
      fontFamily: AppStrings.fontFamily,
      color: color,
      fontWeight: fontWeight);
}


TextStyle getLineOverStyle({bool isBold = true}) {
  return TextStyle(
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColors.primary,
    height: 2,
    decorationThickness: 15,
    fontSize: 16.sp,
    fontFamily: AppStrings.fontFamily,
    color: AppColors.primary,
    fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
  );
}

TextStyle getUnderLine({Color? color, double? fontSize}) {
  return TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: color ?? AppColors.black,
    // height: 2,
    decorationThickness: 4,
    fontSize: fontSize ?? 18.sp,
    fontFamily: AppStrings.fontFamily,
    color: color ?? AppColors.black,
    fontWeight: FontWeight.w500,
  );
}

TextStyle getRegularStyle(
    {Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: fontSize ?? 18.sp,
      fontHeight: fontHeight);
}

TextStyle getMediumStyle({Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 18.sp,
      fontHeight: fontHeight);

}

TextStyle getSemiBoldStyle(
    {Color? color,
    double? fontHeight,
    double? fontSize,
    FontWeight? fontweight}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: fontweight ?? FontWeight.w600,
      fontSize: fontSize ?? 18.sp,
      fontHeight: fontHeight);
}

TextStyle getBoldStyle(
    {Color? color,
    double? fontHeight,
    double? fontSize,
    FontWeight? fontweight}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: fontweight ?? FontWeight.w700,
      fontSize: fontSize ?? 18.sp,
      fontHeight: fontHeight);
}

TextStyle getExtraStyle({Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: FontWeight.w800,
      fontSize: fontSize ?? 18.sp,
      fontHeight: fontHeight);
}
