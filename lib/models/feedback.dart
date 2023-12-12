class FeedbackModel {
  String name, avatar, message;
  double rate;
  DateTime timeCreated;

  FeedbackModel({
    required this.name,
    required this.avatar,
    required this.rate,
    required this.message,
    required this.timeCreated,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      name: json['renterName'] ?? "",
      avatar: json['renterAvatar'] ?? "",
      rate: json['rate'],
      message: json['feedback'] ?? "",
      timeCreated: DateTime.parse(json['feedbackTime'] ?? ""),
    );
  }
}
