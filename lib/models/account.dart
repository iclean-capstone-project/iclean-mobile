class Account {
  String fullName, email, avatar, phoneNumber, defaultAddress, roleName;
  DateTime dateOfBirth;
  bool? isRegistration;
  Account({
    required this.fullName,
    required this.avatar,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.roleName,
    required this.defaultAddress,
    this.isRegistration,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    final dateOfBirthStr = json['dateOfBirth'] as String? ?? "";

    // Split the date and time parts
    final dateAndTimeParts = dateOfBirthStr.split('T');
    final datePart = dateAndTimeParts[0];

    // Parse the date part
    final dateParts = datePart.split('-');
    final year = int.parse(dateParts[2]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[0]);

    final role = json['roleName'] as String? ?? '';
    if (role == "renter") {
      return Account(
        fullName: json['fullName'] ?? '',
        avatar: json['avatar'] ?? '',
        dateOfBirth: DateTime(year, month, day),
        phoneNumber: json['phoneNumber'] ?? '',
        email: json['email'] ?? '',
        roleName: json['roleName'] ?? '',
        defaultAddress: json['defaultAddress'] ?? '',
        isRegistration: json['isRegistration'],
      );
    } else if (role == "helper") {
      return Account(
        fullName: json['fullName'] ?? '',
        avatar: json['avatar'] ?? '',
        dateOfBirth: DateTime(year, month, day),
        phoneNumber: json['phoneNumber'] ?? '',
        email: json['email'] ?? '',
        roleName: json['roleName'] ?? '',
        defaultAddress: json['defaultAddress'] ?? '',
      );
    }
    return Account(
      fullName: json['fullName'] ?? '',
      avatar: json['avatar'] ?? '',
      dateOfBirth: DateTime(year, month, day),
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      roleName: json['roleName'] ?? '',
      defaultAddress: json['defaultAddress'] ?? '',
    );
  }
}
