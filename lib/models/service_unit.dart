class ServiceUnit {
  int id;
  String value, serviceUnitImage;
  double equivalent;

  ServiceUnit({
    required this.id,
    required this.value,
    required this.equivalent,
    required this.serviceUnitImage,
  });

  factory ServiceUnit.fromJson(Map<String, dynamic> json) {
    return ServiceUnit(
      id: json['serviceUnitId'],
      value: json['value'] ?? "",
      equivalent: json['equivalent'].toDouble() ?? 0,
      serviceUnitImage: json['serviceUnitImage'] ?? "",
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceUnit &&
        other.id == id &&
        other.value == value &&
        other.equivalent == equivalent &&
        other.serviceUnitImage == serviceUnitImage;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      value.hashCode ^
      equivalent.hashCode ^
      serviceUnitImage.hashCode;
}
