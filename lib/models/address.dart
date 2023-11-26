class Address {
  int? id;
  double? longitude, latitude;
  String addressName, description;
  bool isDefault;

  Address({
    required this.id,
    this.longitude,
    this.latitude,
    required this.addressName,
    required this.description,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['addressId'],
      addressName: json['locationName'] ?? "",
      description: json['description'] ?? "",
      isDefault: json['isDefault'],
    );
  }

  factory Address.fromJsonById(Map<String, dynamic> json) {
    return Address(
      id: json['addressId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      addressName: json['locationName'] ?? "",
      description: json['description'] ?? "",
      isDefault: json['isDefault'],
    );
  }
}
