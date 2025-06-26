import '../../../../../core/exports.dart';

class ContainerOfPackage extends StatelessWidget {
  ContainerOfPackage({
    super.key,
    required this.widgetOne,
    required this.widgetTwo,
    this.height,
    this.hideDividor = false,
  });
  Widget widgetOne;
  double? height;
  bool hideDividor;
  Widget widgetTwo;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 72.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(

          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0.02,
              color: AppColors.grayDark
            )
          ],
          borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widgetOne,
          if (hideDividor)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 22.0.w),
              child: VerticalDivider(
                color: AppColors.grayDark,
                thickness: 2.w,
                endIndent: height == null ? 5.h : 20.h,
                indent: height == null ? 5.h : 20.h,
              ),
            ),
          widgetTwo,
        ],
      ),
    );
  }
}
