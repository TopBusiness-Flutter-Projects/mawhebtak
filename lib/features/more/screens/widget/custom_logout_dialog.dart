import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/exports.dart';

class CustomLogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const CustomLogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Row(
        children: [
          SvgPicture.asset(AppIcons.logout, height: 25.h),
          10.w.horizontalSpace,
          Text(
            "logout".tr(),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(
        "are_you_sure_logout".tr(),
        style: TextStyle(fontSize: 14.sp),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "cancel".tr(),
            style: TextStyle(color: AppColors.darkGray),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            "logout".tr(),
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}

class CustomDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const CustomDeleteDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Row(
        children: [
          SvgPicture.asset(AppIcons.deleteAccountIcon, height: 25.h),
          10.w.horizontalSpace,
          Text(
            "delete_account".tr(),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(
        "delete_account_msg".tr(),
        style: TextStyle(fontSize: 14.sp),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "cancel".tr(),
            style: TextStyle(color: AppColors.darkGray),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            "confirm".tr(),
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
