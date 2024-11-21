import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationsService {
  /// This method is used to get the token of the device
  static Future<String> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken() ?? '';
  }

  /// This method is used to initialize the firebase messaging and local notification
  static Future<void> initialize() async {
    /// This method is used to handle messages
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_foregroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_openAppWithNotification);

    /// initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
  }

  /// This method is used to handle background messages
  static Future<void> _backgroundHandler(RemoteMessage message) async {
    log(message.data.toString());
    createNewNotification(
      title: message.notification!.title!,
      description: message.notification!.body!,
    );
  }

  /// This method is used to handle foreground messages
  static Future<void> _foregroundHandler(RemoteMessage message) async {
    log(message.data.toString());
    createNewNotification(
      title: message.notification!.title!,
      description: message.notification!.body!,
    );
  }

  /// This method is used in opening the app with notification
  static Future<void> _openAppWithNotification(RemoteMessage message) async {
    log(message.data.toString());
    createNewNotification(
      title: message.notification!.title!,
      description: message.notification!.body!,
    );
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  static void onDidReceiveNotificationResponse(NotificationResponse details) {}

  static createNewNotification({
    required String title,
    required String description,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'souq_algoumlah_app_channel_id',
      'Souq Algoumlah Channel Name',
      channelDescription: '',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      _generateId(),
      title,
      description,
      notificationDetails,
      payload: title,
    );
  }

  static _generateId() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }
}
