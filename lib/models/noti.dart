class Noti {
  int id;
  String details, imgLink;
  DateTime timestamp;
  bool isRead;

  Noti({
    required this.id,
    required this.details,
    required this.imgLink,
    required this.timestamp,
    required this.isRead,
  });

  factory Noti.fromJson(Map<String, dynamic> json) {
    return Noti(
      id: json['notificationId'],
      details: json['detail'] ?? "",
      imgLink: json['notificationImgLink'] ?? "",
      timestamp: DateTime.parse(json['createAt']),
      isRead: json['isRead'],
    );
  }
}
