import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';
import 'package:mawhebtak/features/more/cubit/more_state.dart';
import 'package:mawhebtak/features/more/data/model/announcement_favourite_model.dart';
import 'package:mawhebtak/features/more/data/model/setting_model.dart';
import 'package:mawhebtak/features/more/data/repos/more.repo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../maintenance_screen.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit(this.api) : super(MoreInitial());
  MoreRepo api;
  int selectedIndex = 0;
  TextEditingController messageController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  Future<LoginModel> getUserFromPreferences() async {
    final user = await Preferences.instance.getUserModel();
    return user;
  }

  LoginModel? user;
  Future<void> loadUserFromPreferences() async {
    user = await Preferences.instance.getUserModel();
  }
  saveData() {
    print('user phone ${user?.data?.phone}');
    phoneNumberController.text = user?.data?.phone ?? "";
  }

  SettingModel? settingModel;
  getSettingData(BuildContext context) async {
    emit(GetSettingDataStateLoading());
    try {
      final res = await api.settingData();
      res.fold((l) {
        emit(GetSettingDataStateError(l.toString()));
      }, (r) async {
        settingModel = r;
        if (r.data?.appMentainance.toString() == 'true') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MaintenanceScreen()));
        }
        await checkAndShowUpdateDialog(
          context: context,
          latestAndroidVersion: r.data?.androidAppVersion ?? "1.0.0",
          latestIosVersion: r.data?.iosAppVersion ?? "1.0.0",
        );
        emit(GetSettingDataStateLoaded());
      });
    } catch (e) {
      emit(GetSettingDataStateError(e.toString()));
    }
  }
//!

  Future<void> checkAndShowUpdateDialog({
    required BuildContext context,
    required String latestAndroidVersion,
    required String latestIosVersion,
  }) async {
    // Get current app version info
    final packageInfo = await PackageInfo.fromPlatform();

    // Determine platform and latest version
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final latestVersion = isIOS ? latestIosVersion : latestAndroidVersion;

    // Extract build numbers for comparison
    final currentBuild = int.tryParse(packageInfo.buildNumber) ?? 0;
    final latestBuild = extractBuildMetadata(latestVersion) ?? 0;

    // Debug prints (optional, can be removed)
    debugPrint('Current: ${packageInfo.version}+${packageInfo.buildNumber}');
    debugPrint('Latest: $latestVersion');

    // Check if update is needed
    final needsUpdate = !isCurrentVersionGreaterThanOrEqual(
      packageInfo.version,
      latestVersion,
      currentBuild,
      latestBuild,
    );

    if (needsUpdate) {
      _showUpdateDialog(context, latestVersion, packageInfo.packageName, isIOS);
    }
  }

  int? extractBuildMetadata(String version) {
    final buildRegExp = RegExp(r'\+(\d+)$');
    final match = buildRegExp.firstMatch(version);
    return match != null ? int.parse(match.group(1)!) : null;
  }

  bool isCurrentVersionGreaterThanOrEqual(
    String currentVersion,
    String targetVersion,
    int currentBuildNumber,
    int targetBuildVersion,
  ) {
    final versionRegExp = RegExp(r'^(\d+)\.(\d+)\.(\d+)');
    final currentMatch = versionRegExp.firstMatch(currentVersion);
    final targetMatch = versionRegExp.firstMatch(targetVersion);

    if (currentMatch == null || targetMatch == null) {
      throw FormatException('Invalid version format');
    }

    final currentMajor = int.parse(currentMatch.group(1)!);
    final currentMinor = int.parse(currentMatch.group(2)!);
    final currentPatch = int.parse(currentMatch.group(3)!);

    final targetMajor = int.parse(targetMatch.group(1)!);
    final targetMinor = int.parse(targetMatch.group(2)!);
    final targetPatch = int.parse(targetMatch.group(3)!);

    if (currentMajor > targetMajor) return true;
    if (currentMajor < targetMajor) return false;

    if (currentMinor > targetMinor) return true;
    if (currentMinor < targetMinor) return false;

    if (currentPatch > targetPatch) return true;
    if (currentPatch < targetPatch) return false;

    // If version numbers are equal, compare build numbers
    return currentBuildNumber >= targetBuildVersion;
  }

  void _showUpdateDialog(
    BuildContext context,
    String latestVersion,
    String packageName,
    bool isIOS,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.0),
                  child: Icon(
                    Icons.tips_and_updates_rounded,
                    color: Colors.orange,
                  ),
                ),
                Flexible(child: Text('متاح تحديث')),
              ],
            ),
            content: Text(
              'توجد نسخة جديدة ($latestVersion). يرجى التحديث إلى أحدث نسخة.',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('تحديث الان!'),
                onPressed: () async {
                  final url = isIOS
                      ? 'https://apps.apple.com/app/idYOUR_APP_ID' // <-- Replace with your App Store ID
                      : 'https://play.google.com/store/apps/details?id=$packageName';
                  _launchUrl(url);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  AnnouncementFavouriteModel? announcementFavouriteModel;
  getAnnounceFavouritesData() async {
    emit(AnnounceFavouritesDataStateLoading());
    try {
      final res = await api.announcementFavourite();
      res.fold((l) {
        emit(AnnounceFavouritesDataStateError(l.toString()));
      }, (r) {
        announcementFavouriteModel = r;
        emit(AnnounceFavouritesDataStateLoaded());
      });
    } catch (e) {
      emit(AnnounceFavouritesDataStateError(e.toString()));
    }
  }

  UserJobModel? userJobFavouriteModel;
  getUserJobFavouritesData() async {
    emit(UserJobFavouritesDataStateLoading());
    try {
      final res = await api.userJobFavourite();
      res.fold((l) {
        emit(UserJobFavouritesDataStateError(l.toString()));
      }, (r) {
        userJobFavouriteModel = r;

        emit(UserJobFavouritesDataStateLoaded());
      });
    } catch (e) {
      emit(UserJobFavouritesDataStateError(e.toString()));
    }
  }

  contactUs({required bool isComplaining, required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(ContactUsStateLoading());
    try {
      final res = await api.contactUs(
        message: messageController.text,
        subject: titleController.text,
        type: isComplaining ? 'complaints' : 'advertisement',
        phone: phoneNumberController.text,
      );
      res.fold((l) {
        emit(ContactUsStateError(l.toString()));
        Navigator.pop(context);
      }, (r) {
        emit(ContactUsStateLoaded());
        messageController.clear();
        titleController.clear();
        Navigator.pop(context);
      });
    } catch (e) {
      emit(GetSettingDataStateError(e.toString()));
    }
  }

  logout({required BuildContext context}) async {
    emit(LogoutStateLoading());
    try {
      final res = await api.logout();
      res.fold((l) {
        emit(LogoutStateError(l.toString()));
      }, (r) {
        if (r.status == 200) {
          successGetBar('logout_successfully'.tr());
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.loginRoute, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.loginRoute, (route) => false);
        }
        emit(LogoutStateLoaded());
      });
    } catch (e) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.loginRoute, (route) => false);
      emit(LogoutStateError(e.toString()));
    }
  }

  changeSelected(int index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }

  changePassword({required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    try {
      final res = await api.changePassword(
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text);
      res.fold((l) {
        emit(ChangePasswordStateError(l.toString()));
        Navigator.pop(context);
      }, (r) {
        if (r.status == 200) {
          successGetBar('change_password_successfully'.tr());
          emit(ChangePasswordStateLoaded());
          Navigator.pop(context);
          oldPasswordController.clear();
          newPasswordController.clear();
        } else {
          errorGetBar(r.msg.toString());
          Navigator.pop(context);
        }
      });
    } catch (e) {
      emit(ChangePasswordStateError(e.toString()));
    }
  }

  deleteAccount({required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    try {
      final res = await api.deleteAccount();
      res.fold((l) {
        emit(ChangePasswordStateError(l.toString()));
        Navigator.pop(context);
      }, (r) {
        if (r.status == 200) {
          successGetBar(
            'delete_account_successfully'.tr(),
            seconds: 2,
          );
          Navigator.pop(context);
          emit(ChangePasswordStateLoaded());
        } else {
          errorGetBar(r.msg.toString());
          Navigator.pop(context);
        }
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.loginRoute, (route) => false);
      });
    } catch (e) {
      Navigator.pop(context);
      emit(ChangePasswordStateError(e.toString()));
    }
  }
}
