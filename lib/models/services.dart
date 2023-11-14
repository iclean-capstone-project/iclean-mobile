class ServiceImage {
  final String serviceImage;

  ServiceImage({required this.serviceImage});

  factory ServiceImage.fromJson(Map<String, dynamic> json) {
    return ServiceImage(serviceImage: json['serviceImage']);
  }
}

class Service {
  String name, description, icon;
  int id;
  List<ServiceImage> images;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.images,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    final imagesList = json['images'] as List<dynamic>?;

    List<ServiceImage> serviceImages = imagesList != null
        ? imagesList
            .map((imageJson) => ServiceImage.fromJson(imageJson))
            .toList()
        : [];

    return Service(
      id: json['serviceId'],
      name: json['serviceName'],
      description: json['description'] ?? "",
      icon: json['serviceIcon'],
      images: serviceImages,
    );
  }
}
