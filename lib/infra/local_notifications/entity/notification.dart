class AppNotification {
  final String id;
  final String title;
  final String description;
  final Map<String,dynamic> payload;

  const AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.payload,
  });
}