class Department {
  final int id;
  final String name;
  final String description;
  final String surface;
  final String population;
  final String phonePrefix;
  final String capital;

  const Department({
    required this.id,
    required this.name,
    required this.description,
    required this.surface,
    required this.population,
    required this.phonePrefix,
    required this.capital,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    description: json['description'] ?? 'Sin descripción.',
    surface: json['surface']?.toString() ?? 'N/D',
    population: json['population']?.toString() ?? 'N/D',
    phonePrefix: json['phonePrefix']?.toString() ?? 'N/D',
    capital: json['cityCapital']?['name'] ?? 'N/D',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'surface': surface,
    'population': population,
    'phonePrefix': phonePrefix,
    'capital': capital,
  };
}
