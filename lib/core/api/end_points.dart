import 'package:flutter/foundation.dart';

class EndPoints {
  static const String baseUrl =
       'http://192.168.1.18:8000/api/v1/';
  // kReleaseMode
  //     ? 'https://mawhebtak.topbusiness.ebharbook.com/api/v1/'
  //     : 'http://192.168.1.18:8000/api/v1/';
//! Authentication
  static const String loginUrl = '${baseUrl}login';
  static const String homeUrl = '${baseUrl}home';
  static const String addPostUrl = '${baseUrl}store-data';
  static const String addReactionUrl = '${baseUrl}add-reaction';
  static const String unWantedUserUrl = '${baseUrl}un-wanted-user';
  static const String registerUrl = '${baseUrl}register';
  static const String validateDataUrl = '${baseUrl}validate-data';
  static const String forgetPasswordUrl = '${baseUrl}forget-password';
  static const String updatePasswordUrl = '${baseUrl}update-password';
  static const String addReferralCodeUrl = '${baseUrl}add-referral-code';
  static const String loginWithSocial = '${baseUrl}login-with-social';
  static const String addCommentUrl = '${baseUrl}add-comment';
  static const String addCommentReply = '${baseUrl}add-comment-reply';
  static const String addReview = '${baseUrl}add-review';
  //! add event
  static const String getDataBaseUrl = '${baseUrl}get-data';
  static const String storeDataUrl = '${baseUrl}store-data';
  static const String updateDataUrl = '${baseUrl}update-data';
  //! delete
  static const String deleteData = '${baseUrl}delete-data';
  static const String eventCalendarUrl = '${baseUrl}calendar';
  static const String storeEventUrl = '${baseUrl}store-event';
  static const String getDetailsDataUrl = '${baseUrl}get-details-data';
  static const String followUnfollowEventUrl =
      '${baseUrl}follow-unfollow-event';
  static const String applyToEventUrl = '${baseUrl}apply-to-event';
  static const String actionGigsUrl = '${baseUrl}action-gigs/';
  static const String notificationUrl = '${baseUrl}get-notifications';
  static const String actionEventRequestUrl = '${baseUrl}action-event-request/';
  static const String requestGigs = '${baseUrl}request-cancel-gigs';
  static const String followAndUnFollow = '${baseUrl}follow-unfollow-user';
  static const String toggleFavorite = '${baseUrl}toggle-favourite';
  static const String profile = '${baseUrl}profile/';
  static const String updateProfile = '${baseUrl}update-profile';
  static const String getDetailsById = '${baseUrl}get-by-id/';
  static const String createChatRoomUrl = '${baseUrl}get-chat-rooms';
  static const String getChatsUrl = '${baseUrl}get-chats';
  static const String settingUrl = '${baseUrl}get-setting';
  static const String changePasswordUrl = '${baseUrl}change-password';
  static const String logoutUrl = '${baseUrl}logout';
  static const String favouritesUrl = '${baseUrl}get-favourites';
  static const String toggleLanguage = '${baseUrl}toggle-language';
  static const String searchRoute = '${baseUrl}search';
  static const String toggleDeleteAccount = '${baseUrl}toggle-delete-account';
}
