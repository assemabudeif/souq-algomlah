// import 'dart:async';
// import 'dart:ui';
//
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '/core/network/api_constance.dart';
// import '/core/services/app_prefs.dart';
// import '/core/utilities/dio_logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class BackgroundService {
//   // this will be used as notification channel id
//   static const notificationChannelId = 'my_foreground';
//
// // this will be used for notification id, So you can update your custom notification with this id.
//   static const notificationId = 888;
//
//   Future<void> initializeService() async {
//     final service = FlutterBackgroundService();
//
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       notificationChannelId, // id
//       'MY FOREGROUND SERVICE', // title
//       description:
//           'This channel is used for important notifications.', // description
//       importance: Importance.low, // importance must be at low or higher level
//     );
//
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     await service.configure(
//         androidConfiguration: AndroidConfiguration(
//           // this will be executed when app is in foreground or background in separated isolate
//           onStart: onStart,
//           autoStartOnBoot: true,
//           // auto start service
//           autoStart: true,
//           isForegroundMode: true,
//
//           notificationChannelId: notificationChannelId,
//           // this must match with notification channel you created above.
//           initialNotificationTitle: 'AWESOME SERVICE',
//           initialNotificationContent: 'Initializing',
//           foregroundServiceNotificationId: notificationId,
//         ),
//         iosConfiguration: IosConfiguration(
//           // this will be executed when app is in foreground or background in separated isolate
//           onBackground: onBackground,
//           onForeground: onForeground,
//           // auto start service
//           autoStart: true,
//         ));
//   }
//
//   @pragma('vm:entry-point')
//   static Future<dynamic> onStart(ServiceInstance service) async {
//     // Only available for flutter 3.0.0 and later
//     DartPluginRegistrant.ensureInitialized();
//
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.setBool('isServiceRunning', true);
//     // final prefs =
//     await SharedPreferences.getInstance().then((value) {
//       final sessionID = value.getInt(SharedKey.sessionId.toString()) ?? -1;
//
//       // AppPreferences().getSessionId();
//       // final getTokenPath = ApiConstance.viewTokens;
//       print('Session ID: $sessionID');
//       if (sessionID == -1) {
//         return;
//       } else {
//         Timer.periodic(
//           const Duration(seconds: 5),
//           (timer) async {
//             DioLogger.getDio().get(ApiConstance.viewTokens).then(
//                   (value) => print(value.data),
//                 );
//             // NotificationsService.createNewNotification(
//             //   title: 'Date Time',
//             //   description: '${DateTime.now()}',
//             // );
//             if (service is AndroidServiceInstance) {
//               if (await service.isForegroundService()) {
//                 flutterLocalNotificationsPlugin.show(
//                   notificationId,
//                   'COOL SERVICE',
//                   'Awesome ${DateTime.now()}',
//                   const NotificationDetails(
//                     android: AndroidNotificationDetails(
//                       notificationChannelId,
//                       'MY FOREGROUND SERVICE',
//                       icon: 'ic_bg_service_small',
//                       ongoing: true,
//                     ),
//                   ),
//                 );
//               }
//             }
//           },
//         );
//       }
//     });
//     // prefs.reload(); // The magic line
//     // prefs.setBool('isServiceRunning', true);
//     // final sessionID = prefs.getInt('sessionId');
//     // final sessionID = prefs.getInt(SharedKey.sessionId.toString()) ?? -1;
//     //
//     // // AppPreferences().getSessionId();
//     // // final getTokenPath = ApiConstance.viewTokens;
//     // print('Session ID: $sessionID');
//     // if (sessionID == -1) {
//     //   return;
//     // } else {
//     //   Timer.periodic(
//     //     const Duration(seconds: 5),
//     //     (timer) async {
//     //       DioLogger.getDio().get(ApiConstance.viewTokens).then(
//     //             (value) => print(value.data),
//     //           );
//     //       // NotificationsService.createNewNotification(
//     //       //   title: 'Date Time',
//     //       //   description: '${DateTime.now()}',
//     //       // );
//     //       if (service is AndroidServiceInstance) {
//     //         if (await service.isForegroundService()) {
//     //           flutterLocalNotificationsPlugin.show(
//     //             notificationId,
//     //             'COOL SERVICE',
//     //             'Awesome ${DateTime.now()}',
//     //             const NotificationDetails(
//     //               android: AndroidNotificationDetails(
//     //                 notificationChannelId,
//     //                 'MY FOREGROUND SERVICE',
//     //                 icon: 'ic_bg_service_small',
//     //                 ongoing: true,
//     //               ),
//     //             ),
//     //           );
//     //         }
//     //       }
//     //     },
//     //   );
//     // }
//
//     // bring to foreground
//     /* Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) async {
//         if (service is AndroidServiceInstance) {
//           if (await service.isForegroundService()) {
//             flutterLocalNotificationsPlugin.show(
//               notificationId,
//               'COOL SERVICE',
//               'Awesome ${DateTime.now()}',
//               const NotificationDetails(
//                 android: AndroidNotificationDetails(
//                   notificationChannelId,
//                   'MY FOREGROUND SERVICE',
//                   icon: 'ic_bg_service_small',
//                   ongoing: true,
//                 ),
//               ),
//             );
//           }
//         }
//       },
//     );*/
//   }
//
//   @pragma('vm:entry-point')
//   FutureOr<bool> onBackground(ServiceInstance service) {
//     return true;
//   }
//
//   @pragma('vm:entry-point')
//   onForeground(ServiceInstance service) {}
// }
