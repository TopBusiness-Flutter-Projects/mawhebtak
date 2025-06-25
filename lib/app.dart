import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/screens/work_details_screen.dart';
import 'package:mawhebtak/features/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/on_boarding/cubit/onboarding_cubit.dart';
import 'package:mawhebtak/features/auth/splash/screens/splash_screen.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/screens/details_of_post.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubits/notifications_cubit/notification_cubit.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/notification_screen.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/main_screen/cubit/cubit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_cubit.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_cubit.dart';
import 'package:mawhebtak/features/my_advertiment_screen/cubit/cubit.dart';
import 'package:mawhebtak/features/packages/cubit/cubit.dart';
import 'package:mawhebtak/features/profile/screens/profile_screen.dart';
import 'package:mawhebtak/features/referral_code/cubit/referral_code_cubit.dart';
import 'package:mawhebtak/features/search/cubit/search_cubit.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/notification_services/notification_service.dart';
import 'core/preferences/hive/models/work_model.dart';
import 'core/utils/app_strings.dart';
import 'package:mawhebtak/injector.dart' as injector;
import 'features/announcement/cubit/announcement_cubit.dart';
import 'features/announcement/screens/details_announcement.dart';
import 'features/auth/splash/cubit/cubit.dart';
import 'features/casting/cubit/casting_cubit.dart';
import 'features/casting/screens/gigs_details.dart';
import 'features/change_langauge/cubit/change_language_cubit.dart';
import 'features/chat/cubit/chat_cubit.dart';
import 'features/events/cubit/event_cubit.dart';
import 'features/auth/login/cubit/cubit.dart';
import 'features/auth/verification/cubit/verification_cubit.dart';
import 'features/events/screens/details_event_screen.dart';
import 'features/home/cubits/top_events_cubit/top_events_cubit.dart';
import 'features/location/cubit/location_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'initialization.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => injector.serviceLocator<SplashCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<MoreCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<NotificationCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<AnnouncementCubit>(),
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
            create: (_) => injector.serviceLocator<MyAdvertismentCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<NewPasswordCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ChangeLanguageCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ReferralCodeCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ProfileCubit>(),
          ),
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
            create: (_) => injector.serviceLocator<AssistantCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<AnnouncementCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<TopTalentsCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                injector.serviceLocator<FeedsCubit>()..postsData(page: '1'),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<SearchCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<LocationCubit>()
              ..checkAndRequestLocationPermission(context),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<PackagesCubit>(),
          ),
          BlocProvider(
              create: (_) => injector.serviceLocator<TopEventsCubit>()),
          BlocProvider(create: (_) => injector.serviceLocator<ChatCubit>()),
        ],
        child: GetMaterialApp(
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: appThemeLight(),
          themeMode: ThemeMode.light,
          navigatorKey: notificationService?.navigatorKey,
          darkTheme: ThemeData.light(),
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          routes: {
            '/': (context) => isWithNotification
                ? initialMessageRcieved?.data['reference_table'] ==
                        "add_assistant"
                    ? WorkDetailsScreen(
                        work: WorkModel(
                            id: initialMessageRcieved?.data['id'],
                            title: initialMessageRcieved?.data['title'],
                            assistants: []))
                    : (initialMessageRcieved?.data['reference_table'] ==
                            "posts")
                        ? PostDetailsScreen(
                            deepLinkDataModel: DeepLinkDataModel(
                                id: initialMessageRcieved?.data['reference_id']
                                        .toString() ??
                                    '',
                                isDeepLink: true))
                        : (initialMessageRcieved?.data['reference_table'] ==
                                "events")
                            ? DetailsEventScreen(
                                eventDataModel: DeepLinkDataModel(
                                    id: initialMessageRcieved?.data['reference_id']
                                            .toString() ??
                                        '',
                                    isDeepLink: true))
                            : (initialMessageRcieved?.data['reference_table'] ==
                                    "profile")
                                ? ProfileScreen(
                                    model: DeepLinkDataModel(
                                        id: initialMessageRcieved
                                                ?.data['reference_id']
                                                .toString() ??
                                            '',
                                        isDeepLink: true))
                                : (initialMessageRcieved?.data['reference_table'] ==
                                        "gigs")
                                    ? GigsDetailsScreen(
                                        id: DeepLinkDataModel(
                                            id: initialMessageRcieved?.data['reference_id'].toString() ?? '',
                                            isDeepLink: true))
                                    : //! userjobs

                                    (initialMessageRcieved?.data['reference_table'] == "user_jobs")
                                        ? GigsDetailsScreen(
                                            id: DeepLinkDataModel(
                                                id: initialMessageRcieved
                                                        ?.data['reference_id']
                                                        .toString() ??
                                                    '',
                                                isDeepLink: true),
                                          )
                                        :

                                        //! Announcement

                                        (initialMessageRcieved?.data['reference_table'] == "announcements")
                                            ? DetailsAnnouncementScreen(
                                                isDeeplink: true,
                                                announcementId:
                                                    initialMessageRcieved?.data[
                                                                'reference_id']
                                                            .toString() ??
                                                        '',
                                              )
                                            : const NotificationScreen()
                : const SplashScreen()
          },
        ));
  }
}
