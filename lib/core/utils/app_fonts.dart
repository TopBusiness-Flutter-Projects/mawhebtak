import 'package:mawhebtak/core/exports.dart';

TextStyle _getTextStyle(
    {required double fontSize,
    double? fontHeight,
    List<Shadow>? shadows,
    required FontWeight fontWeight,
    required Color color}) {
  return TextStyle(
      height: fontHeight,
      fontSize: fontSize,
      fontFamily: AppStrings.fontFamily,
      color: color,
      shadows: shadows,
      fontWeight: fontWeight);
}

TextStyle getLineOverStyle({bool isBold = true, bool isShadow = false}) {
  return TextStyle(
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColors.primary,
    height: 2,
    decorationThickness: 15,
    fontSize: 16.sp,
    fontFamily: AppStrings.fontFamily,
    shadows: isShadow == true
        ? [
            Shadow(
                offset: Offset(1, 1), // Shadow position
                blurRadius: 2, // How soft the shadow should be
                color: Colors.black.withOpacity(0.5)), // Shadow color
          ]
        : [],
    color: AppColors.primary,
    fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
  );
}

TextStyle getUnderLine(
    {Color? color, double? fontSize, bool isShadow = false}) {
  return TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: color ?? AppColors.black,
    // height: 2,
    decorationThickness: 2,
    fontSize: fontSize ?? 18.sp,
    fontFamily: AppStrings.fontFamily,
    shadows: isShadow == true
        ? [
            Shadow(
                offset: Offset(1, 1), // Shadow position
                blurRadius: 2, // How soft the shadow should be
                color: Colors.black.withOpacity(0.5)), // Shadow color
          ]
        : [],
    color: color ?? AppColors.black,
    fontWeight: FontWeight.w500,
  );
}

TextStyle getRegularStyle(
    {Color? color,
    double? fontHeight,
    double? fontSize,
    bool isShadow = false}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: FontWeight.w400,
      shadows: isShadow == true
          ? [
              Shadow(
                  offset: Offset(1, 1), // Shadow position
                  blurRadius: 2, // How soft the shadow should be
                  color: Colors.black.withOpacity(0.5)), // Shadow color
            ]
          : [],
      fontSize: fontSize ?? 18.sp,
      fontHeight: fontHeight);
}

TextStyle getMediumStyle(
    {Color? color,
    double? fontHeight,
    double? fontSize,
    bool isShadow = false}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 18.sp,
      shadows: isShadow == true
          ? [
              Shadow(
                  offset: Offset(1, 1), // Shadow position
                  blurRadius: 2, // How soft the shadow should be
                  color: Colors.black.withOpacity(0.5)), // Shadow color
            ]
          : [],
      fontHeight: fontHeight);
}

TextStyle getSemiBoldStyle(
    {Color? color,
    double? fontHeight,
    double? fontSize,
    bool isShadow = false,
    FontWeight? fontweight}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: fontweight ?? FontWeight.w600,
      fontSize: fontSize ?? 18.sp,
      shadows: isShadow == true
          ? [
              Shadow(
                  offset: Offset(1, 1), // Shadow position
                  blurRadius: 2, // How soft the shadow should be
                  color: Colors.black.withOpacity(0.5)), // Shadow color
            ]
          : [],
      fontHeight: fontHeight);
}

TextStyle getBoldStyle(
    {Color? color,
    double? fontHeight,
    double? fontSize,
    bool isShadow = false,
    FontWeight? fontweight}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: fontweight ?? FontWeight.w700,
      fontSize: fontSize ?? 18.sp,
      shadows: isShadow == true
          ? [
              Shadow(
                  offset: Offset(1, 1), // Shadow position
                  blurRadius: 2, // How soft the shadow should be
                  color: Colors.black.withOpacity(0.5)), // Shadow color
            ]
          : [],
      fontHeight: fontHeight);
}

TextStyle getExtraStyle(
    {Color? color,
    double? fontHeight,
    double? fontSize,
    bool isShadow = false}) {
  return _getTextStyle(
      color: color ?? AppColors.black,
      fontWeight: FontWeight.w800,
      fontSize: fontSize ?? 18.sp,
      shadows: isShadow == true
          ? [
              Shadow(
                  offset: Offset(1, 1), // Shadow position
                  blurRadius: 2, // How soft the shadow should be
                  color: Colors.black.withOpacity(0.5)), // Shadow color
            ]
          : [],
      fontHeight: fontHeight);
}
