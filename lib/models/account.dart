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
}
