import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationservice {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  bool get initialized => _initialized;
  //
  Future<void> initNotifications() async {
    if (_initialized) return;

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await notificationsPlugin.initialize(initializationSettings);
  }
  //detail for notification

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  //
  Future<void> showNotification({
    int id = 0,
    required String title,
    required String body,
  }) async {
    try {
      await notificationsPlugin.show(id, title, body, notificationDetails());
    } catch (e) {
      print("Lỗi khi hiển thị notification: $e");
    }
  }
}
