import 'package:mawhebtak/core/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.title, this.color});
  final void Function()? onTap;
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.white,
              fontFamily: AppStrings.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
