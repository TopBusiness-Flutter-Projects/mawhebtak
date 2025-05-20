import 'dart:async';
import 'dart:developer';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/notification_services/notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    log('PPPPPPPP$isWithNotification${initialMessageRcieved?.data['type']}');

    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 3, milliseconds: 500),
      () {
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? firstInstall = await Preferences.instance.getFirstInstall();

    if (firstInstall != null) {
      if (prefs.getString('user') != null) {
        print("main screen");
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        print("login");
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginRoute,
          ModalRoute.withName(Routes.initialRoute),
        );
      }
    } else {
      print("onboarding");
      Navigator.pushReplacementNamed(
        context,
        Routes.onboardingPageScreenRoute,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // context.read<SplashCubit>().getAdsOfApp();

    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: SizedBox(
                child: Image.asset(
                  ImageAssets.appIcon,
                  height: getSize(context) / 1.3,
                  width: getSize(context) / 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //   },
    // );
  }
}
