import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawhebtak/initialization.dart';
import 'app.dart';
import 'core/utils/restart_app_class.dart';

void main() async {
  await initialization();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: true,
      startLocale: const Locale('en', ''),
      fallbackLocale: const Locale('en', ''),
      child: HotRestartController(
          child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, child) {
          return const MyApp();
        },
      )),
    ),
  );
}
