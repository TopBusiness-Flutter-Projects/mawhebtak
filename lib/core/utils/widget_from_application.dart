import 'package:flutter/material.dart';
import 'package:mawhebtak/core/exports.dart';
import '../widgets/show_loading_indicator.dart';
import 'app_colors.dart';

class AppWidgets {
  static createProgressDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.primary),
                Text(
                  msg,
                  style: TextStyle(color: AppColors.black, fontSize: 15.0),
                )
              ],
            ),
          );
        });
  }

  static snackBar(String? message, context, {Color? color}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: message == "loading" ? AppColors.white : color,
        elevation: 0,
        content: message == "loading"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ],
              )
            : Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: AppColors.white),
              ),
        duration: Duration(milliseconds: message == "loading" ? 1500 : 3000),
      ),
    );
  }

  static create2ProgressDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const CustomLoadingIndicator(withLogo: true);
        });
  }

  static buttonSheet(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: SafeArea(
            child: Column(
              children: [
                10.h.verticalSpace,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                10.h.verticalSpace,
                Expanded(child: child),
              ],
            ),
          ),
        );
      },
    );
  }
}
