import 'package:dio/dio.dart';
import 'package:mawhebtak/features/auth/change_password/data/repos/change_password_repo.dart';
import 'package:mawhebtak/features/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:mawhebtak/features/auth/forget_password/data/repos/forget_password_repo.dart';
import 'package:mawhebtak/features/auth/login/cubit/cubit.dart';
import 'package:mawhebtak/features/auth/login/data/login_repo.dart';
import 'package:mawhebtak/features/auth/on_boarding/cubit/onboarding_cubit.dart';
import 'package:mawhebtak/features/auth/splash/cubit/cubit.dart';
import 'package:mawhebtak/features/change_langauge/cubit/change_language_cubit.dart';
import 'package:mawhebtak/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:mawhebtak/features/contact_us/data/repos/contact_us_repo.dart';
import 'package:mawhebtak/features/main_screen/cubit/cubit.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_cubit.dart';
import 'package:mawhebtak/features/auth/new_password/data/repos/new_password_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:mawhebtak/features/auth/verification/cubit/verification_cubit.dart';
import 'package:mawhebtak/features/auth/verification/data/repos/verification.repo.dart';
import 'package:mawhebtak/features/referral_code/cubit/about_us_cubit.dart';
import 'package:mawhebtak/features/referral_code/data/repos/referral_code_repo.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'features/about_us/cubit/about_us_cubit.dart';
import 'features/about_us/data/repos/about_us_repo.dart';
import 'features/auth/change_password/cubit/change_password_cubit.dart';
import 'features/change_langauge/data/repos/change_language_repo.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/home/data/repo/home_repo_impl.dart';
import 'features/main_screen/data/repo/main_repo_impl.dart';

// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
//!-------------------------Declare Cubit-------------------------

  serviceLocator.registerFactory(
    () => SplashCubit(),
  );

  serviceLocator.registerFactory(
    () => LoginCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MainCubit(
      serviceLocator(),
    ),
  );serviceLocator.registerFactory(
    () => HomeCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => OnboardingCubit(

    ),
  ); serviceLocator.registerFactory(
    () => ForgetPasswordCubit(
      serviceLocator(),
    ),
  );
   serviceLocator.registerFactory(
    () => VerificationCubit(
      serviceLocator(),
    ),
  );  serviceLocator.registerFactory(
    () => NewPasswordCubit(
      serviceLocator(),
    ),
  ); serviceLocator.registerFactory(
    () => ContactUsCubit(
      serviceLocator(),
    ),
  ); serviceLocator.registerFactory(
    () => ChangePasswordCubit(
      serviceLocator(),
    ),
  );serviceLocator.registerFactory(
    () => ChangeLanguageCubit(
      serviceLocator(),
    ),
  );serviceLocator.registerFactory(
    () => AboutUsCubit(
      serviceLocator(),
    ),
  );serviceLocator.registerFactory(
    () => ReferralCodeCubit(
      serviceLocator(),
    ),
  );

//!----------------------------------------------------------------
///////////////////////////////////////////////////////////////////
//!-------------------------Declare Repo---------------------------
  serviceLocator.registerLazySingleton(() => LoginRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => MainRepoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => HomeRepoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ForgetPasswordRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => VerificationRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => NewPasswordRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ContactUsRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ChangePasswordRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ChangeLanguageRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AboutUsRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ReferralCodeRepo(serviceLocator()));

//!----------------------------------------------------------------

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  ///! (dio)
  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
}
