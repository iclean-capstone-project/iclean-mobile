class Account {
  int? id;
  String fullname, profilePicture, phone, address, role;
  String email;
  DateTime dateOfBirth;

  Account({
    required this.id,
    required this.fullname,
    required this.profilePicture,
    required this.dateOfBirth,
    required this.phone,
    required this.email,
    required this.role,
    required this.address,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    final dateOfBirthStr = json['dateOfBirth'] as String;

    // Split the date and time parts
    final dateAndTimeParts = dateOfBirthStr.split('T');
    final datePart = dateAndTimeParts[0];

    // Parse the date part
    final dateParts = datePart.split('-');
    final year = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[2]);

    final id = json['userId'] as int?;
    final fullname = json['fullname'] as String;
    final profilePicture = json['profilePicture'] as String? ?? "";
    final dateOfBirth = DateTime(year, month, day);
    final phone = json['phone'] as String;
    final email = json['email'] as String? ?? "";
    final role = json['role'] as String;
    final address = json['address'] as String;

    return Account(
      id: id,
      fullname: fullname,
      profilePicture: profilePicture,
      dateOfBirth: dateOfBirth,
      phone: phone,
      email: email,
      role: role,
      address: address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'profilePicture': profilePicture,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phone': phone,
      'email': email,
      'role': role,
      'address': address,
    };
  }
}
