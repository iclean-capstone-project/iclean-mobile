class Helper {
  int id, serviceId, numberOfFeedback;
  String name, avatar, phoneNumber;
  double rate;
  String? email;

  Helper({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.avatar,
    required this.rate,
    required this.phoneNumber,
    required this.numberOfFeedback,
    this.email,
  });

  factory Helper.fromJson(Map<String, dynamic> json) {
    return Helper(
      id: json['helperId'],
      serviceId: json['serviceId'],
      name: json['helperName'] ?? "",
      avatar: json['helperAvatar'] ?? "",
      rate: json['rate'],
      phoneNumber: json['phoneNumber'] ?? "",
      numberOfFeedback: json['numberOfFeedback'],
    );
  }
}
