class Address {
  int? id;
  double longitude, latitude;
  String addressName, description;
  bool isDefault;

  Address({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.addressName,
    required this.description,
    required this.isDefault,
  });
}
