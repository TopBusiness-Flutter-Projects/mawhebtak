import 'package:dio/dio.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/data/repos/assistant.repo.dart';
import 'package:mawhebtak/features/auth/change_password/data/repos/change_password_repo.dart';
import 'package:mawhebtak/features/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:mawhebtak/features/auth/forget_password/data/repos/forget_password_repo.dart';
import 'package:mawhebtak/features/auth/login/cubit/cubit.dart';
import 'package:mawhebtak/features/auth/login/data/repos/login_repo.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/data/repos/new_account.repo.dart';
import 'package:mawhebtak/features/auth/on_boarding/cubit/onboarding_cubit.dart';
import 'package:mawhebtak/features/auth/splash/cubit/cubit.dart';
import 'package:mawhebtak/features/calender/data/repos/calender.repo.dart';
import 'package:mawhebtak/features/change_langauge/cubit/change_language_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/data/repository/feeds_repository.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/data/repositories/home_repository.dart';
import 'package:mawhebtak/features/home/data/repositories/top_talents_repository.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/data/repos/jobs.repo.dart';
import 'package:mawhebtak/features/main_screen/cubit/cubit.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_cubit.dart';
import 'package:mawhebtak/features/auth/new_password/data/repos/new_password_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:mawhebtak/features/auth/verification/cubit/verification_cubit.dart';
import 'package:mawhebtak/features/auth/verification/data/repos/verification.repo.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_cubit.dart';
import 'package:mawhebtak/features/more_screen/data/repos/more.repo.dart';
import 'package:mawhebtak/features/referral_code/cubit/referral_code_cubit.dart';
import 'package:mawhebtak/features/referral_code/data/repos/referral_code_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'features/announcement/cubit/announcement_cubit.dart';
import 'features/announcement/data/repo/announcement_repo_impl.dart';
import 'features/calender/cubit/calender_cubit.dart';
import 'features/casting/cubit/casting_cubit.dart';
import 'features/casting/data/repos/casting.repo.dart';
import 'features/chat/cubit/chat_cubit.dart';
import 'features/chat/data/repos/chat_repo.dart';
import 'features/events/cubit/event_cubit.dart';
import 'features/events/data/repo/event_repo_impl.dart';

import 'features/auth/change_password/cubit/change_password_cubit.dart';
import 'features/change_langauge/data/repos/change_language_repo.dart';
import 'features/home/cubits/top_events_cubit/top_events_cubit.dart';
import 'features/home/data/repositories/top_events_repository.dart';
import 'features/location/cubit/location_cubit.dart';
import 'features/main_screen/data/repo/main_repo_impl.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/profile/data/repo/profile_repo_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> setupCubit() async {
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
  );
  serviceLocator.registerFactory(
    () => HomeCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ChatCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => AnnouncementCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => OnboardingCubit(),
  );
  serviceLocator.registerFactory(
    () => ForgetPasswordCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => VerificationCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => NewPasswordCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => EventCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => ChangePasswordCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ProfileCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ChangeLanguageCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => ReferralCodeCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => NewAccountCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CalenderCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CastingCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => JobsCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => AssistantCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => TopTalentsCubit(),
  );
  serviceLocator.registerFactory(
    () => MoreCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => TopEventsCubit(),
  );
  serviceLocator.registerFactory(() => FeedsCubit());
  serviceLocator.registerFactory(() => LocationCubit());
}

Future<void> setupRepo() async {
  serviceLocator.registerLazySingleton(() => LoginRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => MainRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => HomeRepository(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ForgetPasswordRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => VerificationRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => NewPasswordRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ChangePasswordRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ChangeLanguageRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ReferralCodeRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => EventRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ProfileRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => AnnouncementRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => NewAccount(serviceLocator()));
  serviceLocator.registerLazySingleton(() => CalenderRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => CastingRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => JobsRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AssistantRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => TopTalentsRepository(serviceLocator()));
  serviceLocator.registerLazySingleton(() => FeedsRepository(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => TopEventsRepository(serviceLocator()));
  serviceLocator.registerLazySingleton(() => MoreRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ChatRepo(serviceLocator()));
}

Future<void> setupSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());
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
