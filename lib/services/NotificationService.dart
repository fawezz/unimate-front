import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static int notifId = 0;
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  //final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveLocalNotification);
  }

  void onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) {
    print(notificationResponse.payload);
  }

  void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      //behaviorSubject.add(payload);
    }
  }

  void showNotif() async {
    const AndroidNotificationDetails androidChannelDetails =
        AndroidNotificationDetails("1", "UniMate",
            icon: "@mipmap/launcher_icon",
            priority: Priority.high,
            importance: Importance.defaultImportance);
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidChannelDetails);
    await _localNotifications.show(notifId++, 'new schedule',
        "Next week's schedule is uploaded!", notificationDetails);
  }
}
