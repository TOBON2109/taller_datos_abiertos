class Airport {
  final int id;
  final String name;
  final String iataCode;
  final String oaciCode;
  final String type;
  final String? latitude;
  final String? longitude;
  final String? departmentName;

  const Airport({
    required this.id,
    required this.name,
    required this.iataCode,
    required this.oaciCode,
    required this.type,
    this.latitude,
    this.longitude,
    this.departmentName,
  });

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    iataCode: json['iataCode'] ?? 'N/D',
    oaciCode: json['oaciCode'] ?? 'N/D',
    type: json['type'] ?? 'N/D',
    latitude: json['latitude']?.toString(),
    longitude: json['longitude']?.toString(),
    departmentName: json['department']?['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'iataCode': iataCode,
    'oaciCode': oaciCode,
    'type': type,
    'latitude': latitude,
    'longitude': longitude,
    'departmentName': departmentName,
  };
}
