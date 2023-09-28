import 'package:cinnamon_riverpod_2/infra/local_notifications/entity/notification.dart';
import 'package:cinnamon_riverpod_2/infra/local_notifications/notification_service.dart';

/// Most common implementation is one which reschedules all schedulable entites at once
///
class LocalNotificationServiceImpl implements NotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<void> scheduleNotifications(List<AppNotification> notifications) async {}
}
