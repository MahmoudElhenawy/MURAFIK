class DoctorAlertEntity {
  final Map<String, dynamic> raw;
  final int id;
  final int sensorId;
  final String sensorName;
  final String currentValue;
  final String alertType;
  final DateTime? createdAt;
  final Map<String, dynamic>? normalRange;
  final int? patientId;
  final String? patientName;

  DoctorAlertEntity({
    required this.raw,
    required this.id,
    required this.sensorId,
    required this.sensorName,
    required this.currentValue,
    required this.alertType,
    required this.createdAt,
    required this.normalRange,
    this.patientId,
    this.patientName,
  });
}
