import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constants/app_constants.dart';
import '../networks/api_acess.dart';
import 'di.dart';

///  MUST be top-level function
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("BG Title: ${message.notification?.title}");
  log("BG Body: ${message.notification?.body}");
  log("BG Data: ${message.data}");
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Used for important notifications',
        importance: Importance.high,
      );

  /* ---------------- DEVICE ID ---------------- */

  Future<String?> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // ANDROID_ID
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }

  /* ---------------- LOCAL NOTIFICATION ---------------- */

  Future<void> _initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          final data = jsonDecode(response.payload!);
          handleMessage(RemoteMessage.fromMap(data));
        }
      },
    );

    final androidPlatform =
        _localNotification
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    await androidPlatform?.createNotificationChannel(_androidChannel);
  }

  /* ---------------- PUSH NOTIFICATION ---------------- */

  Future<void> _initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.data),
      );
    });
  }

  /* ---------------- MESSAGE HANDLER ---------------- */

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    log("📩 Notification clicked");
    log("📩 Data: ${message.data}");

    // Example navigation
    // NavigationService.navigateTo(Routes.notificationScreen);
  }

  /* ---------------- INIT NOTIFICATION ---------------- */

  Future<void> initNotification() async {
    try {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      final fcmToken = await _firebaseMessaging.getToken();
      final deviceId = await _getDeviceId();

      log("FCM Token =====>>> $fcmToken");
      log("Device ID =====>>> $deviceId");

      appData.write(kKeyFCMToken, fcmToken);
      appData.write(kKeyDeviceID, deviceId);

      await _initLocalNotification();
      await _initPushNotification();

      addDeviceRxxObj.addDeviceRx(
        token: fcmToken!,
        deviceId: deviceId!,
      );
    } catch (e) {
      log("Notification init error: $e");
    }
  }
}
