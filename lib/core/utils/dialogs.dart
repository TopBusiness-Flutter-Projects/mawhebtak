import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_core/get_core.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

/*----------------------------------------------------------------------------*/
/*------------------------------  Error Get Bar  -----------------------------*/
/*----------------------------------------------------------------------------*/
errorGetBar(String message) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message,
        style: Get.textTheme.titleSmall!.copyWith(
          color: Colors.white,
          height: 1.3,
        ),
      ),
      icon: const Icon(Icons.error_outline_outlined, color: Colors.white),
      backgroundColor: AppColors.error,
      barBlur: 5.0,
      borderRadius: 12.0,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      margin: const EdgeInsets.all(12.0),
      snackPosition: SnackPosition.BOTTOM,
    ),
  );
}

/*----------------------------------------------------------------------------*/
/*------------------------------  Success Get Bar  ---------------------------*/
/*----------------------------------------------------------------------------*/

successGetBar(String? message) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      message ?? 'success'.tr(),
      style: Get.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        height: 1.5,
      ),
    ),
    icon: const Icon(CupertinoIcons.checkmark_seal, color: Colors.white),
    backgroundColor: AppColors.success,
    barBlur: 5.0,
    borderRadius: 12.0,
    duration: const Duration(milliseconds: 2500),
    isDismissible: true,
    margin: const EdgeInsets.all(8.0),
    snackPosition: SnackPosition.TOP,
  ));
}

/*----------------------------------------------------------------------------*/
/*------------------------------  Message Get Bar  ---------------------------*/
/*----------------------------------------------------------------------------*/
messageGetBar(String message) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      message,
      style: Get.textTheme.labelMedium!.copyWith(
        color: Colors.white,
        height: 1.5,
      ),
    ),
    icon: const Icon(CupertinoIcons.arrow_left_circle, color: Colors.white),
    backgroundColor: Get.theme.primaryColor,
    barBlur: 5.0,
    borderRadius: 12.0,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    margin: const EdgeInsets.all(8.0),
    snackPosition: SnackPosition.TOP,
  ));
}

/*----------------------------------------------------------------------------*/
/*------------------------------  Loading Dialog  ----------------------------*/
/*----------------------------------------------------------------------------*/
// loadingDialog() {
//   Get.dialog(
//     Dialog(
//       backgroundColor: Colors.white,
//       insetAnimationCurve: Curves.bounceInOut,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 25),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'جارى التحميل'.tr,
//               style: Get.textTheme.labelMedium!.copyWith(
//                 color: Get.theme.primaryColor,
//               ),
//             ),
//             const SizedBox(width: 5),
//             // SpinKitCircle(),vx
//             CircularProgressIndicator(color: Get.theme.colorScheme.secondary),
//           ],
//         ),
//       ),
//     ),
//     barrierDismissible: false,
//     transitionCurve: Curves.easeInOutBack,
//   );
// }

//!----------------------------------------------------------------------------/
//!------------------------------  Loading Dialog we will use it  -------------/
//!----------------------------------------------------------------------------/

loadingDialog({required bool isLoading, required Widget child}) {
  return OverlayLoaderWithAppIcon(
      isLoading: isLoading,
      circularProgressColor: AppColors.primary,
      borderRadius: 15.0,
      appIcon: Image.asset(ImageAssets.appIcon),
      child: Container(child: child));
}

/*----------------------------------------------------------------------------*/
/*------------------------------  Bottom Sheet  ----------------------------*/
/*----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/*------------------------------  Custom Dialogs  ----------------------------*/
/*----------------------------------------------------------------------------*/

// checkLoggingStatus(BuildContext context, {void Function()? onPressed}) async {
//   print("AppConst.isLogged: ${AppConst.isLogged}");
//   if (AppConst.isLogged) {
//     if (onPressed != null) {
//       onPressed();
//     }
//   } else {
//     await AwesomeDialog(
//       context: context,
//       customHeader: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Image.asset(
//           ImageAssets.logoImage,
//         ),
//       ),
//       animType: AnimType.topSlide,
//       showCloseIcon: true,
//       padding: EdgeInsets.all(10.w),
//       title: AppTranslations.notLogin,
//       titleTextStyle: getRegularStyle(fontSize: 16.sp),
//       btnOkText: AppTranslations.login,
//       btnOkOnPress: () {
//         Navigator.pushNamedAndRemoveUntil(
//             context, Routes.loginRoute, (route) => false);
//       },
//       btnCancelOnPress: () {},
//       btnCancelText: AppTranslations.cancel,
//     ).show();
//   }
// }

/// check is Go Tohome
// checkGoToHome(BuildContext context, {String? message}) async {
//   await AwesomeDialog(
//     context: context,
//     customHeader: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Image.asset(
//         ImageAssets.logoImage,
//       ),
//     ),
//     animType: AnimType.topSlide,
//     padding: EdgeInsets.all(10.w),
//     title: AppTranslations.reservationWillCanceled,
//     titleTextStyle: getRegularStyle(fontSize: 16.sp),
//     showCloseIcon: true,
//     btnOk: CustomButton(
//         title: AppTranslations.goHome,
//         onTap: () {
//           Navigator.pushNamedAndRemoveUntil(
//               context, Routes.mainRoute, (route) => false);
//         }),
//   ).show();
// }

// Exit app
// showExitDialog(BuildContext context) async {
//   AwesomeDialog(
//     context: context,
//     // dialogType: DialogType.noHeader, // Change to CUSTOM to use custom header
//     customHeader: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Image.asset(
//         ImageAssets.logoImage,
//         // height: 50.h,
//         // width: 50.h,
//       ),
//     ),
//     animType: AnimType.topSlide,
//     padding: EdgeInsets.all(10.w),
//     title: AppTranslations.areYouSureClose,
//     titleTextStyle: getRegularStyle(fontSize: 16.sp),
//     showCloseIcon: true,
//
//     btnOkText: AppTranslations.exit,
//     btnOkOnPress: () {
//       Navigator.of(context).pop();
//       SystemNavigator.pop();
//     },
//     btnCancelOnPress: () {},
//     btnCancelText: AppTranslations.cancel,
//   ).show();
//   //  showDialog<void>(
//   //   context: context,
//   //   barrierDismissible: false,
//   //   builder: (BuildContext context) {
//   //     return AlertDialog(
//   //       title: Text(AppTranslations.areYouSureClose),
//   //       content: Text(AppTranslations.appClose),
//   //       actions: <Widget>[
//   //         TextButton(
//   //           child: Text(AppTranslations.cancel),
//   //           onPressed: () {
//   //             Navigator.of(context).pop();
//   //           },
//   //         ),
//   //         TextButton(
//   //           child: Text(AppTranslations.exit),
//   //           onPressed: () {
//   //             Navigator.of(context).pop();
//   //             SystemNavigator.pop();
//   //           },
//   //         ),
//   //       ],
//   //     );
//   //   },
//   // );
// }

deleteAccountDialog(BuildContext context, {void Function()? onPressed}) async {
  await AwesomeDialog(
    context: context,
    customHeader: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        ImageAssets.logoImage,
      ),
    ),
    animType: AnimType.topSlide,
    showCloseIcon: true,
    padding: EdgeInsets.all(10.w),
    title: "delete_account_desc".tr(),
    titleTextStyle: getRegularStyle(fontSize: 16.sp),
    btnOkText: "delete".tr(),
    btnOkOnPress: onPressed,
    btnOkColor: AppColors.primary,
    btnCancelOnPress: () {},
    btnCancelText: "cancel".tr(),
  ).show();
}

mainAppAwsomeDialog(
  BuildContext context, {
  void Function()? onPressed,
  String? title,
  String? btnOkText,
}) async {
  await AwesomeDialog(
    context: context,
    customHeader: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        ImageAssets.logoImage,
      ),
    ),
    animType: AnimType.topSlide,
    showCloseIcon: true,
    padding: EdgeInsets.all(10.w),
    title: title,
    titleTextStyle: getRegularStyle(fontSize: 16.sp),
    btnOkText: btnOkText ?? "delete".tr(),
    btnOkOnPress: onPressed,
    btnOkColor: AppColors.primary,
    btnCancelOnPress: () {},
    btnCancelText: "cancel".tr(),
  ).show();
}
