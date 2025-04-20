import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/about_us/cubit/about_us_cubit.dart';
import 'package:mawhebtak/features/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/on_boarding/cubit/onboarding_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/main_screen/cubit/cubit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_cubit.dart';
import 'package:mawhebtak/features/records/cubit/records_cubit.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'package:mawhebtak/injector.dart' as injector;

import 'features/auth/change_password/cubit/change_password_cubit.dart';
import 'features/auth/splash/cubit/cubit.dart';
import 'features/casting/cubit/casting_cubit.dart';
import 'features/change_langauge/cubit/change_language_cubit.dart';
import 'features/events/cubit/event_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/auth/login/cubit/cubit.dart';
import 'features/auth/verification/cubit/verification_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/referral_code/cubit/about_us_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(text);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => injector.serviceLocator<SplashCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<EventCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<HomeCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<LoginCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<MainCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<OnboardingCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ForgetPasswordCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<VerificationCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<NewPasswordCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ContactUsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ChangePasswordCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ChangeLanguageCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<AboutUsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ReferralCodeCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ProfileCubit>(),
          ),


          //sanssssssssssssssssssssssssssss
          BlocProvider(
            create: (_) => injector.serviceLocator<NewAccountCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<CalenderCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<CastingCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<JobsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<RecordsCubit>(),
          ),
        ],
        child: GetMaterialApp(
          supportedLocales: context.supportedLocales,

          locale: context.locale,
          theme: appTheme(),
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.light(),
          // standard dark theme
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ));
  }
}
