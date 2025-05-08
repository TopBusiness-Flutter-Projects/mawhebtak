import 'package:flutter/foundation.dart';

class EndPoints {
  static const String baseUrl = kReleaseMode
      ? 'mawhebtak.topbusiness.ebharbook.com/api/v1/'
      : 'http://192.168.117.185:8000/api/v1/';
  // : 'http://192.168.1.18:8000/api/v1/';
  static const String loginUrl = '${baseUrl}login';
  static const String homeUrl = '${baseUrl}home';
}
