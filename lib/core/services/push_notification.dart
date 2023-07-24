import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:moury/core/services/life_cycle_manager.dart';

int notificationId = 0;
const String groupKey = 'com.moury.app';
bool isAppInForeground = false;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message);
}

void serialiseAndNavigate(
  RemoteMessage message,
) async {
  Map<String, dynamic> data = message.data;

  Get.toNamed(
    "/single-chat",
    arguments: {
      "userId": data['user_id'],
      "username": data['username'],
      "userImage": data["profile_picture"] ?? ''
    },
  );
}

void showNotification(RemoteMessage message) async {
  String? title = message.notification?.title;
  String? body = message.notification?.body;

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/moury');

  var initializationSettingsIOS = const IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  final localNotifications = FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'Main Channel',
    'Main Channel',
    channelDescription: "All message related notifications",
    playSound: true,
    icon: "@mipmap/moury",
    channelShowBadge: true,
    enableVibration: true,
    importance: Importance.max,
    priority: Priority.high,
    groupKey: groupKey,
  );

  var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
    presentSound: true,
    presentAlert: true,
    presentBadge: true,
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await localNotifications.initialize(
    initializationSettings,
    onSelectNotification: (payload) async {
      if (payload != null) {
        Map<String, dynamic> data = json.decode(payload);
        Get.toNamed(
          "/single-chat",
          arguments: {
            "userId": data['user_id'],
            "username": data['username'],
            "userImage": data["profile_picture"]
          },
        );
      }
    },
  );

  try {
    await localNotifications.show(
      ++notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
    showSummaryNotification(localNotifications);
  } catch (e) {
    print(e);
  }
}

void showSummaryNotification(
    FlutterLocalNotificationsPlugin localNotifications) async {
  var bigTextStyleInformation = const BigTextStyleInformation(
      '<hidden due to privacy>',
      htmlFormatBigText: true,
      contentTitle: '<hidden due to privacy> messages',
      htmlFormatContentTitle: true,
      summaryText: 'you have <hidden due to privacy> messages',
      htmlFormatSummaryText: true);

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Main Channel', 'Main Channel',
      channelDescription: "All message related notifications",
      styleInformation: bigTextStyleInformation,
      groupKey: groupKey,
      setAsGroupSummary: true);

  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await localNotifications.show(
    0, // ID of summary notification must be different
    'Attention',
    'You have received new messages',
    platformChannelSpecifics,
  );
}

class PushNotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initialise({List<String> topics = const []}) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((message) {
      if (LifeCycleManager.to.isAppInForeground.value) {
        // Do not show the notification
      } else {
        showNotification(message);
      }
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      serialiseAndNavigate(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      serialiseAndNavigate(message);
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    for (var element in topics) {
      print(element);
      messaging.subscribeToTopic(element);
    }

    return await messaging.getToken();
  }

  void unsubscribe(List<String> topics) {
    for (var element in topics) {
      messaging.unsubscribeFromTopic(element);
    }
  }

  Future<void> delete() async {
    await messaging.deleteToken();
  }
}
