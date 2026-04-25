class NaturalArea {
  final int id;
  final String name;
  final String description;
  final String? longitude;
  final String? latitude;
  final String? category;
  final String? departmentName;

  const NaturalArea({
    required this.id,
    required this.name,
    required this.description,
    this.longitude,
    this.latitude,
    this.category,
    this.departmentName,
  });

  factory NaturalArea.fromJson(Map<String, dynamic> json) => NaturalArea(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    description: json['description'] ?? 'Sin descripción.',
    longitude: json['longitude']?.toString(),
    latitude: json['latitude']?.toString(),
    category: json['categoryNaturalArea']?['name'],
    departmentName: json['department']?['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'longitude': longitude,
    'latitude': latitude,
    'category': category,
    'departmentName': departmentName,
  };
}
