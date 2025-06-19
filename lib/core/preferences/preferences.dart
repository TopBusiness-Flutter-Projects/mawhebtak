import 'dart:convert';
import 'package:mawhebtak/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/login/data/models/login_model.dart';

late SharedPreferences prefs;

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('onBoarding', 'Done');
  }

  Future<String?> getFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.get('onBoarding');
    if (value is String) {
      return value;
    } else {
      return null; // or handle the case accordingly
    }
  }

  Future<void> setUser(LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'user', jsonEncode(LoginModel.fromJson(loginModel.toJson())));
    print(await getUserModel());
  }

  /// Save app language using SharedPreferences
  Future<void> savedLang(String local) async {
    await prefs.setString(AppStrings.locale, local);
  }

  /// Get app language using SharedPreferences
  Future<String> getSavedLang() async {
    return prefs.getString(AppStrings.locale) ?? 'en'; // Default to 'ar'
  }

  Future<void> clearShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Future<LoginModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    LoginModel userModel;
    if (jsonData != null) {
      userModel = LoginModel.fromJson(jsonDecode(jsonData));
    } else {
      userModel = LoginModel();
    }
    return userModel;
  }

  Future<void> setDeviceToken(String token) async {
    print('=====>> $token');
    await prefs.setString('device_token', token);
  }

  /// Get app language using SharedPreferences
  Future<String> getDeviceToken() async {
    return prefs.getString('device_token') ?? 'device_token';
  }
}
