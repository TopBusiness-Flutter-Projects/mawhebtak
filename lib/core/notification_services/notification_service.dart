import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import '../../features/events/screens/details_event_screen.dart';
import '../exports.dart';
import '../preferences/preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

bool isWithNotification = false;
String notificationId = "0";
String notificationType = "";
RemoteMessage? initialMessageRcieved;
WorkModel? remoteWorModel;

class NotificationService {
  tz.TZDateTime _convertToTZDateTime(DateTime dateTime) {
    tz.initializeTimeZones(); // Ideally move this to app startup
    final location = tz.local;
    return tz.TZDateTime.from(dateTime, location);
  }

  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  /// Global Key for Navigation
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Firebase Messaging Instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Local Notifications Plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int _notificationCounter = 0;

  /// **Initialize Notifications**
  Future<void> initialize() async {
    await _initializeFirebaseMessaging();
    await _initializeLocalNotifications();
  }

  /// **Firebase Messaging Initialization**
  Future<void> _initializeFirebaseMessaging() async {
    // Handle when app is completely closed and opened via notification
    //! [Kill]
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      initialMessageRcieved = initialMessage;
      isWithNotification = true;

      //! open
    }

    // Handle notification click when app is in
    //! [ background ]
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Handle notification click when app is in forground
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      initialMessageRcieved = message;

      if (message.data['reference_table'] == "add_assistant") {
        navigatorKey.currentState?.pushNamed(Routes.workDetailsRoute,
            arguments: WorkModel(
                id: message.data['id'],
                title: message.data['title'],
                assistants: []));
      } else if (message.data['reference_table'] == "posts") {
        navigatorKey.currentState?.pushNamed(Routes.postDetailsRoute,
            arguments: DeepLinkDataModel(
                id: message.data['reference_id'].toString(), isDeepLink: true));
      } else if (message.data['reference_table'] == "events") {
        navigatorKey.currentState?.pushNamed(Routes.eventsDetailsRoute,
            arguments: DeepLinkDataModel(
                id: message.data['reference_id'].toString(), isDeepLink: true));
      } else if (message.data['reference_table'] == "profile") {
        navigatorKey.currentState?.pushNamed(Routes.profileDetailsRoute,
            arguments: DeepLinkDataModel(
                id: message.data['reference_id'].toString(), isDeepLink: true));
      }

      //! GIGS
      else if (message.data['reference_table'] == "gigs") {
        navigatorKey.currentState?.pushNamed(Routes.gigsDetailsScreen,
            arguments: DeepLinkDataModel(
                id: message.data['reference_id'].toString(), isDeepLink: true));
      } //! userjobs

      else if (message.data['reference_table'] == "user_jobs") {
        navigatorKey.currentState
            ?.pushNamed(Routes.jobDetailsRoute, arguments: {
          "isDeepLink": true,
          'userJopId': message.data['reference_id'].toString(),
        });
      }

      //! Announcement
      else if (message.data['reference_table'] == "announcements") {
        navigatorKey.currentState
            ?.pushNamed(Routes.detailsAnnouncementScreen, arguments: {
          "isDeepLink": true,
          'announcementId': message.data['reference_id'].toString(),
        });
      } else {
        navigatorKey.currentState?.pushNamed(Routes.notificationRoute);
      }
      // //!
      // else {
      //   navigatorKey.currentState
      //       ?.pushNamed(Routes.notificationRoute, arguments: userType);
      // }
    });

    // Request notification permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

//! [Forground ]
    FirebaseMessaging.onMessage.listen((message) {
      print("Foreground Message Received: ${message.notification?.title}");
      print("Message Data: ${message.data}");

      /// Check if the message is from a chat room
      final roomId = message.data['modal_id']?.toString();

      if (MessageStateManager().isInChatRoom("0")) {
        log("Already in chat room $roomId - skipping notification");
        return;
      }
      // if (MessageStateManager().isInChatRoom(roomId)) {
      //   log("Already in chat room $roomId - skipping notification");
      //   return;
      // }

      _showLocalNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        payload: jsonEncode(message.data), // message.data.toString(),
      );
    });
    await _getToken();
  }

  /// **Handles Background Notifications**
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    initialMessageRcieved = message;
    isWithNotification = true;
    print("Background Message Received: ${message.notification?.title}");
  }

  /// **Fetches and Stores FCM Token**

  Future<String?> _getToken() async {
    try {
      Preferences.instance.init();
      // Request permission (if needed)
      await _messaging.requestPermission();
      // Get the device token
      String? deviceToken = await _messaging.getToken();
      log("token ====>> $deviceToken");
      // Save the token to preferences
      await Preferences.instance.setDeviceToken(deviceToken ?? '');
      return deviceToken;
    } catch (e) {
      log("Error getting token: $e");
      return null;
    }
  }

  /// **Local Notifications Initialization**
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,

      ///! [ON CLIECK LOCAL NOTFICATION]
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;

        log('Notification payload: $payload userType==>');
        try {
          if (payload != null) {
            Map<String, dynamic> message = {};
            message = jsonDecode(payload);
            log('Notification payload: ${message['type']} userType==>');
            log('Notification message after parsing: $message');
            //!
            initialMessageRcieved = RemoteMessage(data: message);
            isWithNotification = true;
            //!
            if (message['reference_table'] == "add_assistant") {
              navigatorKey.currentState?.pushNamed(Routes.workDetailsRoute,
                  arguments: WorkModel(
                      id: message['id'],
                      title: message['title'],
                      assistants: []));
            } else if (message['reference_table'] == "posts") {
              navigatorKey.currentState?.pushNamed(Routes.postDetailsRoute,
                  arguments: DeepLinkDataModel(
                      id: message['reference_id'].toString(),
                      isDeepLink: true));
            } else if (message['reference_table'] == "events") {
              navigatorKey.currentState?.pushNamed(Routes.eventsDetailsRoute,
                  arguments: DeepLinkDataModel(
                      id: message['reference_id'].toString(),
                      isDeepLink: true));
            } else if (message['reference_table'] == "profile") {
              navigatorKey.currentState?.pushNamed(Routes.profileDetailsRoute,
                  arguments: DeepLinkDataModel(
                      id: message['reference_id'].toString(),
                      isDeepLink: true));
            }

            //! GIGS
            else if (message['reference_table'] == "gigs") {
              navigatorKey.currentState?.pushNamed(Routes.gigsDetailsScreen,
                  arguments: DeepLinkDataModel(
                      id: message['reference_id'].toString(),
                      isDeepLink: true));
            } //! userjobs

            else if (message['reference_table'] == "user_jobs") {
              navigatorKey.currentState
                  ?.pushNamed(Routes.jobDetailsRoute, arguments: {
                "isDeepLink": true,
                'userJopId': message['reference_id'].toString(),
                'index': 0,
              });
            }

            //! Announcement
            else if (message['reference_table'] == "announcements") {
              navigatorKey.currentState
                  ?.pushNamed(Routes.detailsAnnouncementScreen, arguments: {
                "isDeepLink": true,
                'announcementId': message['reference_id'].toString(),
              });
            } else {
              navigatorKey.currentState?.pushNamed(Routes.notificationRoute);
            }
          }
        } catch (e) {
          log('Error parsing notification payload: $e');
          // navigatorKey.currentState
          //     ?.pushNamed(Routes.notificationRoute, );
        }
      },
    );

    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
    'your_channel_id_mawhebtak',
    'your_channel_name_mawhebtak',
    channelDescription: 'your_channel_description_mawhebtak',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    ticker: 'ticker',
  );

  /// **Shows a Local Notification**
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
        _notificationCounter++, title, body, notificationDetails,
        payload: payload);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    // const androidDetails = AndroidNotificationDetails(
    //   'your_channel_id_mawhebtak',
    //   'your_channel_name_mawhebtak',
    //   channelDescription: 'your_channel_description_mawhebtak',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   icon: '@mipmap/ic_launcher',
    //   ticker: 'ticker',
    // );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _convertToTZDateTime(scheduledTime),
      notificationDetails,
      // matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
    print('Notification with ID $id canceled');
  }
}

class MessageStateManager {
  static final MessageStateManager _instance = MessageStateManager._internal();
  factory MessageStateManager() => _instance;
  MessageStateManager._internal();

  // Track active chat room IDs
  final Set<String> _activeChatRoomIds = {};

  // Methods to update state
  void enterChatRoom(String roomId) {
    _activeChatRoomIds.add(roomId);
    log("Entered chat room: $roomId");
  }

  void leaveChatRoom(String roomId) {
    _activeChatRoomIds.remove(roomId);
    log("Left chat room: $roomId");
  }

  // Check if we're in a specific chat room
  bool isInChatRoom(String? roomId) {
    return roomId != null && _activeChatRoomIds.contains(roomId);
  }
}
