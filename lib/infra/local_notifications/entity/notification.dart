import 'package:equatable/equatable.dart';
import 'package:timezone/timezone.dart';

class AppNotification extends Equatable {
  final String id;
  final String title;
  final String description;
  final Map<String, dynamic> payload;
  final TZDateTime scheduledDate;
  const AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.payload,
    required this.scheduledDate,
  });

  @override
  List<Object?> get props => [id, title, description, payload, scheduledDate];
}
