class Account {
  int? id;
  String fullname, profilePicture, phone, email, address, role;
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

  // factory Account.fromJson(Map<String, dynamic> json) {
  //   return Account(
  //     id: json['userId'] as int?,
  //     fullname: json['fullname'] as String,
  //     profilePicture: json['profilePicture'] as String? ?? "",
  //     dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
  //     phone: json['phone'] as String,
  //     email: json['email'] as String,
  //     role: json['roleName'] as String? ?? "",
  //     address: json['address'] as String? ?? "",
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'fullname': fullname,
  //     'profilePicture': role,
  //     'dateOfBirth': dateOfBirth.toIso8601String(),
  //     'phone': phone,
  //     'email': email,
  //     'role': role,
  //     'address': address,
  //   };
  // }
}
