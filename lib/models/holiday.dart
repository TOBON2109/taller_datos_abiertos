class Holiday {
  final String date;
  final String name;
  final String type;
  final String? description;

  const Holiday({
    required this.date,
    required this.name,
    required this.type,
    this.description,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    date: json['date'] ?? '',
    name: json['name'] ?? '',
    type: json['type'] ?? 'N/D',
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'name': name,
    'type': type,
    'description': description,
  };
}
