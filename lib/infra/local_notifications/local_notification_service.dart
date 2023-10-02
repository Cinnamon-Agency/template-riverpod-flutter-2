import 'package:cinnamon_riverpod_2/infra/local_notifications/entity/notification.dart';
import 'package:cinnamon_riverpod_2/infra/local_notifications/notification_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Most common implementation is one which reschedules all schedulable entites at once

class LocalNotificationServiceImpl implements NotificationService {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  @override
  Future<void> scheduleNotifications(List<AppNotification> notifications) async {
    await cancelAll();
    await Future.wait(notifications.mapIndexed(_schedule));
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {}

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {}

  @override
  Future<void> cancelAll() {
    return _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _schedule(int index, AppNotification element) {
    return _flutterLocalNotificationsPlugin.zonedSchedule(
        index, element.title, element.description, element.scheduledDate, const NotificationDetails(),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime);
  }
}
