import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/features/about_us/screens/about_us_screen.dart';
import 'package:mawhebtak/features/announcement/screens/all_announcements_screen.dart';
import 'package:mawhebtak/features/announcement/screens/details_of_main_category_announcment.dart';
import 'package:mawhebtak/features/assistant/screens/add_assistant_screen.dart';
import 'package:mawhebtak/features/assistant/screens/add_new_work_screen.dart';
import 'package:mawhebtak/features/assistant/screens/work_details_screen.dart';
import 'package:mawhebtak/features/assistant/screens/work_screen.dart';
import 'package:mawhebtak/features/auth/change_password/screens/change_password_screen.dart';
import 'package:mawhebtak/features/auth/forget_password/screens/forget_password_screen.dart';
import 'package:mawhebtak/features/auth/new_account/screens/new_account_screen.dart';
import 'package:mawhebtak/features/auth/on_boarding/screen/onboarding_screen.dart';
import 'package:mawhebtak/features/auth/splash/screens/splash_screen.dart';
import 'package:mawhebtak/features/calender/screens/calender_screen.dart';
import 'package:mawhebtak/features/casting/screens/casting_screen.dart';
import 'package:mawhebtak/features/casting/screens/chat_screen.dart';
import 'package:mawhebtak/features/casting/screens/details_of_main_category_gigs.dart';
import 'package:mawhebtak/features/casting/screens/details_of_main_category_top_talents.dart';
import 'package:mawhebtak/features/casting/screens/gigs_details.dart';
import 'package:mawhebtak/features/change_langauge/screens/change_language_screen.dart';
import 'package:mawhebtak/features/contact_us/screens/contact_us_screen.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/request_gigs_screen.dart';
import 'package:mawhebtak/features/home/screens/top_talents_screen.dart';
import 'package:mawhebtak/features/jobs/screens/job_details_screen.dart';
import 'package:mawhebtak/features/jobs/screens/jobs_screen.dart';
import 'package:mawhebtak/features/main_screen/screens/main_screen.dart';
import 'package:mawhebtak/features/auth/new_password/screens/new_password_screen.dart';
import 'package:mawhebtak/features/auth/verification/screens/verification_screen.dart';
import 'package:mawhebtak/features/more_screen/screens/more_screen.dart';
import 'package:mawhebtak/features/calender/screens/new_event_screen.dart';
import 'package:mawhebtak/features/profile/screens/edit_profile_screen.dart';
import 'package:mawhebtak/features/terms_and_condition/screens/terms_and_condition.dart';
import '../../core/utils/app_strings.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/announcement/screens/announcement_screen.dart';
import '../../features/announcement/screens/details_announcement.dart';
import '../../features/announcement/screens/new_announcement.dart';
import '../../features/auth/login/screens/login_screen.dart';
import '../../features/events/screens/apply_for_event.dart';
import '../../features/events/screens/details_event_screen.dart';
import '../../features/feeds/screens/details_of_post.dart';
import '../../features/feeds/screens/write_post.dart';
import '../../features/home/screens/top_events_screen.dart';
import '../../features/feeds/screens/feeds_screen.dart';
import '../../features/home/screens/notification_screen.dart';
import '../../features/jobs/screens/add_new_job_screen.dart';
import '../../features/profile/screens/followers_screen.dart';
import '../../features/casting/screens/new_gigs_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/referral_code/screens/referral_code_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String mainRoute = '/main';
  static const String onboardingPageScreenRoute = '/onboardingPageScreenRoute';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String verificationRoute = '/verification';
  static const String newPasswordRoute = '/newPassword';
  static const String moreRoute = '/more';
  static const String changeLanguageRoute = '/changeLanguage';
  static const String changePasswordRoute = '/changePassword';
  static const String aboutUsRoute = '/aboutUs';
  static const String contactUsRoute = '/contactUs';
  static const String referralCodeRoute = '/referralCode';
  static const String termsAndConditionRoute = '/termsAndCondition';
  static const String videoScreenRoute = '/videoScreenRoute';
  static const String topEventsRoute = '/topEventScreen';
  static const String detailsEventRoute = '/detailsEventScreen';
  static const String notificationRoute = '/notificationScreen';
  static const String secondDetailsSecond = '/secondDetailsSecond';
  static const String applyEvent = '/applyEvent';
  static const String profileScreen = '/profileScreen';
  static const String followersScreen = '/followersScreen';
  static const String writePostScreen = '/writePostScreen';
  static const String newGigsRoute = '/newGigsRoute';
  static const String gigsDetailsScreen = '/gigsDetailsScreen';
  static const String feedsScreen = '/feedsScreen';
  static const String announcementScreen = '/announcementScreen';
  static const String newAnnouncementScreen = '/newAnnouncementScreen';
  static const String detailsAnnouncementScreen = '/detailsAnnouncementScreen';
  static const String newAccountRoute = '/newAccount';
  static const String calenderRoute = '/calender';
  static const String newEventRoute = '/newEvent';
  static const String castingRoute = '/casting';
  static const String jobsRoute = '/jobs';
  static const String addNewJobRoute = '/addNewJob';
  static const String jobDetailsRoute = '/jobDetails';
  static const String recordsRoute = '/records';
  static const String addNewWorkRoute = '/addNewWork';
  static const String workDetailsRoute = '/workDetails';
  static const String addAssistantRoute = '/addAssistant';
  static const String topTalentsRoute = '/topTalentsRoute';
  static const String requestGigsRoute = '/requestGigsRoute';
  static const String allAnnouncementsRoute = '/allAnnouncementsRoute';
  static const String chatRoute = '/chatRoute';
  static const String detailsOfMainCategoryFromGigsRoute =
      '/detailsOfMainCategoryFromGigs';
  static const String detailsOfMainCategoryAnnouncementRoute =
      '/detailsOfMainCategoryAnnouncementRoute';

  static const String detailsOfMainCategoryFromTopTalentsRoute =
      '/detailsOfMainCategoryFromTopTalents';
  static const String postdeepLinkRoute = '/posts';
  static const String profiledeepLinkRoute = '/profiles';
  static const String eventsdeepLinkRoute = '/events';
  static const String editProfileRoute = '/editProfile';
}

class AppRoutes {
  // static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    String route = settings.name ?? '';
    String idLink = '0';
    log('the route is: $route');
    final uri = Uri.parse(route);
    log('the link is: $uri');

    if (uri.queryParameters.containsKey('id')) {
      idLink = uri.queryParameters['id'] ?? '0';
      log('Found ID in query params: $idLink');
    }

    String path = uri.path;

    if (path.contains('/deeplink/')) {
      path = path.split('/deeplink/').last;
      path = '/$path';
    }
    log('Route for matching: $path, ID: $idLink');

    switch (path) {
      // switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.gigsDetailsScreen:
        String id = settings.arguments as String;
        return PageTransition(
          child: GigsDetailsScreen(
            id: id,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.detailsAnnouncementScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          child: DetailsAnnouncementScreen(
            index: args['index'] as int,
            announcementId: args['announcementId'] as String,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.newGigsRoute:
        return PageTransition(
          child: NewGigsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.detailsOfMainCategoryFromGigsRoute:
        String? categoryId = settings.arguments as String;
        return PageTransition(
          child: DetailsOfMainCategoryGigs(
            categoryId: categoryId,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.announcementScreen:
        return PageTransition(
          child: const AnnouncementScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.newAnnouncementScreen:
        return PageTransition(
          child: const NewAnnouncementScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.profileScreen:
        DeepLinkDataModel? model = settings.arguments as DeepLinkDataModel;
        return PageTransition(
          child: ProfileScreen(
            model: model,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.feedsScreen:
        return PageTransition(
          child: const FeedsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.detailsOfMainCategoryAnnouncementRoute:
        String categoryId = settings.arguments as String;
        return PageTransition(
          child: DetailsOfMainCategoryAnnouncement(
            categoryId: categoryId,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.followersScreen:
        return PageTransition(
          child: const FollowersScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      // case Routes.secondDetailsSecond:
      //   String? eventId = settings.arguments as String?;

      //   return PageTransition(
      //     child: SecondDetailsEventScreen(
      //       eventId: eventId,
      //     ),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     duration: const Duration(milliseconds: 300),
      //   );
      case Routes.detailsEventRoute:
        DeepLinkDataModel? eventDataModel =
            settings.arguments as DeepLinkDataModel?;
        return PageTransition(
          child: DetailsEventScreen(
            eventDataModel: eventDataModel,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.topEventsRoute:
        return PageTransition(
          child: const TopEventsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.notificationRoute:
        return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.allAnnouncementsRoute:
        return PageTransition(
          child: const AllAnnouncementsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.workDetailsRoute:
        WorkModel work = settings.arguments as WorkModel;
        return PageTransition(
          child: WorkDetailsScreen(
            work: work,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.editProfileRoute:
        DeepLinkDataModel? model = settings.arguments as DeepLinkDataModel?;
        return PageTransition(
          child: EditProfileScreen(
            model: model!,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      // case Routes.videoScreenRoute:
      // return PageTransition(
      //   child: const VideoScreen(),
      //   type: PageTransitionType.fade,
      //   alignment: Alignment.center,
      //   duration: const Duration(milliseconds: 300),
      // );
      case Routes.onboardingPageScreenRoute:
        return PageTransition(
          child: const OnBoardingScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.mainRoute:
        return PageTransition(
          child: const MainScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.applyEvent:
        return PageTransition(
          child: const ApplyForEvent(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.forgetPasswordRoute:
        return PageTransition(
          child: const ForgetPasswordScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.verificationRoute:
        bool isRegister = settings.arguments as bool;
        return PageTransition(
          child: VerificationScreen(
            isRegister: isRegister,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.newPasswordRoute:
        return PageTransition(
          child: const NewPasswordScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.moreRoute:
        return PageTransition(
          child: const MoreScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.changeLanguageRoute:
        return PageTransition(
          child: const ChangeLanguageScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.changePasswordRoute:
        return PageTransition(
          child: const ChangePasswordScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.aboutUsRoute:
        return PageTransition(
          child: const AboutUsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.termsAndConditionRoute:
        return PageTransition(
          child: const TermsAndConditionScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.contactUsRoute:
        String type = settings.arguments as String;
        return PageTransition(
          child: ContactUsScreen(
            type: type,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.referralCodeRoute:
        return PageTransition(
          child: const ReferralCodeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.newAccountRoute:
        return PageTransition(
          child: const NewAccountScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.calenderRoute:
        return PageTransition(
          child: const CalendarScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.newEventRoute:
        return PageTransition(
          child: const NewEventScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.castingRoute:
        bool isFromHome = settings.arguments as bool;
        return PageTransition(
          child: CastingScreen(
            isFromHome: isFromHome,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.jobsRoute:
        return PageTransition(
          child: const JobsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.addNewJobRoute:
        return PageTransition(
          child: const AddNewJobScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.jobDetailsRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          child: JobDetailsScreen(
            index: args['index'] as int,
            userJopId: args['userJopId'] as String,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.recordsRoute:
        return PageTransition(
          child: const AssistantScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.chatRoute:
        return PageTransition(
          child: const ChatScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.addNewWorkRoute:
        return PageTransition(
          child: const AddNewWorkScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.detailsOfMainCategoryFromTopTalentsRoute:
        return PageTransition(
          child: const DetailsOfMainCategoryTopTalents(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.topTalentsRoute:
        return PageTransition(
          child: BlocProvider(
              create: (context) => TopTalentsCubit()..topTalentsData(page: '1'),
              child: const TopTalentsScreen()),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.requestGigsRoute:
        return PageTransition(
          child: const RequestGigsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.addAssistantRoute:
        final args = settings.arguments as Map<String, dynamic>;
        WorkModel work = args['work'] as WorkModel;
        Assistant? assistant = args.containsKey('assistant')
            ? args['assistant'] as Assistant
            : null;

        return PageTransition(
          child: AddAssistantScreen(
            work: work,
            assistant: assistant,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.writePostScreen:
        return PageTransition(
          child: const WritePost(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );

      //! DEEP LINK ROUTES
      case Routes.eventsdeepLinkRoute:
        log('PPPPPPPP ${DeepLinkDataModel(id: idLink, isDeepLink: true).isDeepLink}');
        log('PPPPPPPP ${DeepLinkDataModel(id: idLink, isDeepLink: true).id}');
        return PageTransition(
          child: DetailsEventScreen(
            eventDataModel: DeepLinkDataModel(id: idLink, isDeepLink: true),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.profiledeepLinkRoute:
        return PageTransition(
          child: ProfileScreen(
              model: DeepLinkDataModel(id: idLink, isDeepLink: true)),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.postdeepLinkRoute:
        return PageTransition(
          child: PostDetailsScreen(
              deepLinkDataModel:
                  DeepLinkDataModel(id: idLink, isDeepLink: true)),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
