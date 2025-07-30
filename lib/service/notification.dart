import 'package:crypto_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:crypto_app/main.dart'; // import để dung navigator key!

class Notificationservice {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  bool get initialized => _initialized;
  final Map<String, WidgetBuilder> payloadRoutes = {
    'open_profile': (_) => MainScreen(initialIndex: 1),
    // thêm nhiều route khác tùy ý
  };

  //
  Future<void> initNotifications() async {
    if (_initialized) return;

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    //

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    //

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null && payloadRoutes.containsKey(payload)) {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: payloadRoutes[payload]!),
          );
          print("Navigating to route for payload: $payload");
        } else {
          print("Payload không hợp lệ hoặc không có route tương ứng.");
        }
      },
    );
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
      ),
    );
  }

  //
  Future<void> showNotification({
    int id = 0,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(),
        payload: payload,
      );
    } catch (e) {
      print("Lỗi khi hiển thị notification: $e");
    }
  }
}
