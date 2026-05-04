import 'package:murafik/feature/patient/domain/entities/patient_alert_entity.dart';

class PatientAlertModel extends PatientAlertEntity {
  PatientAlertModel({
    required Map<String, dynamic> raw,
    required String title,
    required String description,
    required String severity,
    required DateTime? createdAt,
  }) : super(
         raw: raw,
         title: title,
         description: description,
         severity: severity,
         createdAt: createdAt,
       );

  factory PatientAlertModel.fromJson(Map<String, dynamic> json) {
    final sensorName = (json['sensorName'] ?? json['title'] ?? 'Alert')
        .toString();
    final currentValue = json['currentValue'] ?? json['value'];
    final description = currentValue != null
        ? '$sensorName alert at $currentValue'
        : sensorName;
    final severity = (json['alertType'] ?? json['severity'] ?? 'info')
        .toString();
    final createdAtRaw = json['createdAt'] ?? json['timeStamp'] ?? json['time'];

    return PatientAlertModel(
      raw: json,
      title: sensorName,
      description: description,
      severity: severity,
      createdAt: createdAtRaw != null
          ? DateTime.tryParse(createdAtRaw.toString())
          : null,
    );
  }
}
