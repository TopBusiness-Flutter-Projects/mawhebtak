import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawhebtak/initialization.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app.dart';
import 'core/utils/restart_app_class.dart';

void main() async {
  await initialization();
  if (Platform.isAndroid && Platform.version.contains("13")) {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: true,
      startLocale: const Locale('en', ''),
      fallbackLocale: const Locale('en', ''),
      child: HotRestartController(child: Builder(builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return ScreenUtilInit(
            designSize: Size(width, height),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (ctx, child) {
              return const MyApp();
            });
      }))));
}
