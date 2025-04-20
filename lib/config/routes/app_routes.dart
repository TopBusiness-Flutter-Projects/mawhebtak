import 'package:flutter/material.dart';
import 'package:mawhebtak/features/about_us/screens/about_us_screen.dart';
import 'package:mawhebtak/features/auth/change_password/screens/change_password_screen.dart';
import 'package:mawhebtak/features/auth/forget_password/screens/forget_password_screen.dart';
import 'package:mawhebtak/features/auth/new_account/screens/new_account_screen.dart';
import 'package:mawhebtak/features/auth/on_boarding/screen/onboarding_screen.dart';
import 'package:mawhebtak/features/auth/splash/screens/splash_screen.dart';
import 'package:mawhebtak/features/calender/screens/calender_screen.dart';
import 'package:mawhebtak/features/casting/screens/casting_screen.dart';
import 'package:mawhebtak/features/change_langauge/screens/change_language_screen.dart';
import 'package:mawhebtak/features/contact_us/screens/contact_us_screen.dart';
import 'package:mawhebtak/features/jobs/screens/job_details_screen.dart';
import 'package:mawhebtak/features/jobs/screens/jobs_screen.dart';
import 'package:mawhebtak/features/main_screen/screens/main_screen.dart';
import 'package:mawhebtak/features/auth/new_password/screens/new_password_screen.dart';
import 'package:mawhebtak/features/auth/verification/screens/verification_screen.dart';
import 'package:mawhebtak/features/more_screen/screens/more_screen.dart';
import 'package:mawhebtak/features/calender/screens/new_event_screen.dart';
import 'package:mawhebtak/features/records/screens/add_new_record_screen.dart';
import 'package:mawhebtak/features/records/screens/records_screen.dart';
import 'package:mawhebtak/features/terms_and_condition/screens/terms_and_condition.dart';
import '../../core/utils/app_strings.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/auth/login/screens/login_screen.dart';
import '../../features/events/screens/apply_for_event.dart';
import '../../features/events/screens/details_event_screen.dart';
import '../../features/events/screens/event_screen.dart';
import '../../features/events/screens/second_details_screen.dart';
import '../../features/feeds/screens/feeds_screen.dart';
import '../../features/home/screens/notification_screen.dart';
import '../../features/home/screens/video_screen.dart';
import '../../features/jobs/screens/add_new_job_screen.dart';
import '../../features/profile/screens/followers_screen.dart';
import '../../features/profile/screens/gigs_details.dart';
import '../../features/profile/screens/new_gigs_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/write_post.dart';
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
  static const String eventScreen = '/eventScreen';
  static const String detailsEventScreen = '/detailsEventScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String secondDetailsSecond = '/secondDetailsSecond';
  static const String applyEvent = '/applyEvent';
  static const String profileScreen = '/profileScreen';
  static const String followersScreen = '/followersScreen';
  static const String writePostScreen = '/writePostScreen';
  static const String newGigsScreen = '/newGigsScreen';
  static const String gigsDetailsScreen = '/gigsDetailsScreen';
  static const String feedsScreen = '/feedsScreen';





































  //sanaaaaaaaaaaaaaaaaaaaaaaaa


  static const String newAccountRoute = '/newAccount';
  static const String calenderRoute = '/calender';
  static const String newEventRoute = '/newEvent';
  static const String castingRoute = '/casting';
  static const String jobsRoute = '/jobs';
  static const String addNewJobRoute = '/addNewJob';
  static const String jobDetailsRoute = '/jobDetails';
  static const String recordsRoute = '/records';
  static const String addNewRecordRoute = '/addNewRecord';

}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );   case Routes.gigsDetailsScreen:
        return PageTransition(
          child: const GigsDetailsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );    case Routes.newGigsScreen:
        return PageTransition(
          child: const NewGigsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        ); case Routes.writePostScreen:
        return PageTransition(
          child: const WritePost(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        ); case Routes.profileScreen:
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.feedsScreen:
        return PageTransition(
          child: const FeedsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.followersScreen:
        return PageTransition(
          child: const FollowersScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );   case Routes.secondDetailsSecond:
        return PageTransition(
          child: const SecondDetailsEventScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );   case Routes.detailsEventScreen:
        return PageTransition(
          child: const DetailsEventScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );  case Routes.eventScreen:
        return PageTransition(
          child: const EventScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );    case Routes.notificationScreen:
        return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );  case Routes.videoScreenRoute:
        return PageTransition(
          child: const VideoScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.onboardingPageScreenRoute:
        return PageTransition(
          child: const OnBoardingScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );

      case Routes.mainRoute:
        return PageTransition(
          child: const MainScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        ); case Routes.applyEvent:
        return PageTransition(
          child: const ApplyForEvent(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.forgetPasswordRoute:
        return PageTransition(
          child: const ForgetPasswordScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.verificationRoute:
        return PageTransition(
          child: const VerificationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.newPasswordRoute:
        return PageTransition(
          child: const NewPasswordScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.moreRoute:
        return PageTransition(
          child: const MoreScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.changeLanguageRoute:
        return PageTransition(
          child: const ChangeLanguageScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.changePasswordRoute:
        return PageTransition(
          child: const ChangePasswordScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.aboutUsRoute:
        return PageTransition(
          child: const AboutUsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.termsAndConditionRoute:
        return PageTransition(
          child: const TermsAndConditionScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );    case Routes.contactUsRoute:
        return PageTransition(
          child: const ContactUsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );  case Routes.referralCodeRoute:
        return PageTransition(
          child: const ReferralCodeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );





        // sanaaaaaaaaaaaaaaa
        case Routes.newAccountRoute:
        return PageTransition(
          child: const NewAccountScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.calenderRoute:
        return PageTransition(
          child: const CalendarScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.newEventRoute:
        return PageTransition(
          child: const NewEventScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.castingRoute:
        return PageTransition(
          child: const CastingScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.jobsRoute:
        return PageTransition(
          child:  const JobsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.addNewJobRoute:
        return PageTransition(
          child:  const AddNewJobScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.jobDetailsRoute:
        return PageTransition(
          child:  const JobDetailsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.recordsRoute:
        return PageTransition(
          child:  const RecordsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.addNewRecordRoute:
        return PageTransition(
          child:  const AddNewRecordScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
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
