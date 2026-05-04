class PatientReadingEntity {
  final Map<String, dynamic> raw;
  final String name;
  final String value;
  final String unit;
  final DateTime? createdAt;

  PatientReadingEntity({
    required this.raw,
    required this.name,
    required this.value,
    required this.unit,
    required this.createdAt,
  });
}
