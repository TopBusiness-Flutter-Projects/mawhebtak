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
  static const String topTalentsUrl = '${baseUrl}get-data?model=User&where[0]=status,1';
  static const String requestGigsUrl = '${baseUrl}get-data?model=User&where[0]=status,1&paginate=true&page=';
  static const String announcementsUrl = '${baseUrl}get-data?model=Announce&where[0]=expire_in,>=,';
  static const String registerUrl = '${baseUrl}register';
  static const String validateDataUrl = '${baseUrl}validate-data';
  static const String getDataUserTypeUrl = '${baseUrl}get-data?model=UserType';
  static const String forgetPasswordUrl = '${baseUrl}forget-password';

  static const String updatePasswordUrl = '${baseUrl}update-password';
}
