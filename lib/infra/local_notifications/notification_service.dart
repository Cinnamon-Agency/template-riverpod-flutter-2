import 'package:cinnamon_riverpod_2/infra/local_notifications/entity/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinnamon_riverpod_2/infra/local_notifications/local_notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return LocalNotificationServiceImpl();
});

abstract interface class NotificationService {
  Future<void> init();
  Future<void> scheduleNotifications(List<AppNotification> notifications);
  Future<void> cancelAll();
}
