class Noti {
  int id;
  String details, status;
  DateTime timestamp;
  bool isRead, deleted;

  Noti({
    required this.id,
    required this.details,
    required this.status,
    required this.timestamp,
    required this.isRead,
    required this.deleted,
  });
}
