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
  static const String addPostUrl = '${baseUrl}store-data';
  static const String addReactionUrl = '${baseUrl}add-reaction';
  static const String feedsUrl = '${baseUrl}get-data';
  static const String unWantedUserUrl = '${baseUrl}un-wanted-user';
  static const String registerUrl = '${baseUrl}register';
  static const String validateDataUrl = '${baseUrl}validate-data';
  static const String getDataUserTypeUrl = '${baseUrl}get-data?model=UserType&where[0]=status,1';
  static const String forgetPasswordUrl = '${baseUrl}forget-password';
  static const String updatePasswordUrl = '${baseUrl}update-password';
  static const String loginWithSocial = '${baseUrl}login-with-social';
  static const String addCommentUrl = '${baseUrl}add-comment';
  static const String addCommentReply = '${baseUrl}add-comment-reply';
  //! add event
  static const String getDataBaseUrl = '${baseUrl}get-data';
  static const String storeDataUrl = '${baseUrl}store-data';
  //! delete
  static const String deleteData = '${baseUrl}delete-data';
  static const String storeEventUrl = '${baseUrl}store-event';
  static const String getDetailsDataUrl = '${baseUrl}get-details-data';
  static const String followUnfollowEventUrl = '${baseUrl}follow-unfollow-event';
  static const String applyToEventUrl = '${baseUrl}apply-to-event';
  static const String actionGigsUrl = '${baseUrl}action-gigs/';
  static const String notificationUrl = '${baseUrl}get-notifications';
  static const String requestGigs = '${baseUrl}request-gigs';

}
