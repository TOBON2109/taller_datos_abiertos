class President {
  final int id;
  final String name;
  final String lastName;
  final String startPeriodDate;
  final String endPeriodDate;
  final String politicalParty;
  final String description;
  final String? image;

  const President({
    required this.id,
    required this.name,
    required this.lastName,
    required this.startPeriodDate,
    required this.endPeriodDate,
    required this.politicalParty,
    required this.description,
    this.image,
  });

  String get fullName => '$name $lastName';

  factory President.fromJson(Map<String, dynamic> json) => President(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    lastName: json['lastName'] ?? '',
    startPeriodDate: json['startPeriodDate'] ?? '',
    endPeriodDate: json['endPeriodDate'] ?? '',
    politicalParty: json['politicalParty'] ?? 'N/D',
    description: json['description'] ?? 'Sin descripción.',
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'lastName': lastName,
    'startPeriodDate': startPeriodDate,
    'endPeriodDate': endPeriodDate,
    'politicalParty': politicalParty,
    'description': description,
    'image': image,
  };
}
