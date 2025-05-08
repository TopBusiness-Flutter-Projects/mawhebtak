import 'package:flutter/material.dart';
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
            content: Row(
              children: [
                CircularProgressIndicator(color: AppColors.primary),
                const Spacer(),
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
}
