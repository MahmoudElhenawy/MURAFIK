class DoctorReadingEntity {
  final Map<String, dynamic> raw;
  final int id;
  final int sensorId;
  final String sensorName;
  final String unit;
  final String value;
  final DateTime? timeStamp;
  final bool hasAlert;
  final String? alertType;
  final Map<String, dynamic>? normalRange;

  DoctorReadingEntity({
    required this.raw,
    required this.id,
    required this.sensorId,
    required this.sensorName,
    required this.unit,
    required this.value,
    required this.timeStamp,
    required this.hasAlert,
    required this.alertType,
    required this.normalRange,
  });
}
