import 'package:flutter/foundation.dart';

class EndPoints {
  static const String baseUrl =
      // 'https://mawhebtak.topbusiness.ebharbook.com/api/v1/';
      kReleaseMode
          ? 'mawhebtak.topbusiness.ebharbook.com/api/v1/'
          : 'http://192.168.1.18:8000/api/v1/';
//! Authentication
  static const String loginUrl = '${baseUrl}login';
  static const String homeUrl = '${baseUrl}home';
  static const String seeAllEventUrl = '${baseUrl}get-data?model=Event';
  static const String registerUrl = '${baseUrl}register';
  static const String validateDataUrl = '${baseUrl}validate-data';
  static const String getDataUserTypeUrl =
      '${baseUrl}get-data?model=UserType&where[0]=status,1';
  static const String forgetPasswordUrl = '${baseUrl}forget-password';

  static const String updatePasswordUrl = '${baseUrl}update-password';
  static const String loginWithSocial = '${baseUrl}login-with-social';
}
