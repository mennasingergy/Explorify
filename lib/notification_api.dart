import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsApi {
  final _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _notifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        icon: "@mipmap/ic_launcher",
        'new_post',
        'When a new post is added',
        importance: Importance.max,
      ),
    );
  }

  Future showNotification({int id = 0, String? title, String? body}) async {
    _notifications.show(id, title, body, await _notificationDetails());
}
}