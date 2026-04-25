class TouristicAttraction {
  final int id;
  final String name;
  final String description;
  final String? latitude;
  final String? longitude;
  final String? cityName;
  final int? departmentId;

  const TouristicAttraction({
    required this.id,
    required this.name,
    required this.description,
    this.latitude,
    this.longitude,
    this.cityName,
    this.departmentId,
  });

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) =>
      TouristicAttraction(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        description: json['description'] ?? 'Sin descripción.',
        latitude: json['latitude']?.toString(),
        longitude: json['longitude']?.toString(),
        cityName: json['city']?['name'],
        departmentId: json['city']?['departmentId'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'latitude': latitude,
    'longitude': longitude,
    'cityName': cityName,
    'departmentId': departmentId,
  };
}
