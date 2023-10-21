class Account {
  int? id;
  String fullName, avatar, phoneNumber, defaultAddress, roleName;
  String email;
  DateTime dateOfBirth;

  Account({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.roleName,
    required this.defaultAddress,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    final dateOfBirthStr = json['dateOfBirth'] as String;

    // Split the date and time parts
    final dateAndTimeParts = dateOfBirthStr.split('T');
    final datePart = dateAndTimeParts[0];

    // Parse the date part
    final dateParts = datePart.split('-');
    final year = int.parse(dateParts[2]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[0]);

    final id = json['userId'] as int?;
    final fullName = json['fullName'] as String? ?? "";
    final avatar = json['avatar'] as String? ?? "";
    final dateOfBirth = DateTime(year, month, day);
    final phoneNumber = json['phoneNumber'] as String;
    final email = json['email'] as String? ?? "";
    final roleName = json['roleName'] as String? ?? "";
    final defaultAddress = json['defaultAddress'] as String? ?? "";

    return Account(
      id: id,
      fullName: fullName,
      avatar: avatar,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
      email: email,
      roleName: roleName,
      defaultAddress: defaultAddress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'avatar': avatar,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'roleName': roleName,
      'defaultAddress': defaultAddress,
    };
  }
}
