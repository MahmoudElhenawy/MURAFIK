class PatientAlertEntity {
  final Map<String, dynamic> raw;
  final String title;
  final String description;
  final String severity;
  final DateTime? createdAt;

  PatientAlertEntity({
    required this.raw,
    required this.title,
    required this.description,
    required this.severity,
    required this.createdAt,
  });
}
