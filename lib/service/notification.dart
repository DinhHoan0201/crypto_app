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

    _initialized = true;
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
        showWhen: false,
      ),
    );
  }

  //
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(),
    );
  }
}
