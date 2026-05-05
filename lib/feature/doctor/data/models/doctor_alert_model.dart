import 'package:murafik/feature/doctor/domain/entities/doctor_alert_entity.dart';

class DoctorAlertModel extends DoctorAlertEntity {
  DoctorAlertModel({
    required Map<String, dynamic> raw,
    required int id,
    required int sensorId,
    required String sensorName,
    required String currentValue,
    required String alertType,
    required DateTime? createdAt,
    required Map<String, dynamic>? normalRange,
    int? patientId,
    String? patientName,
  }) : super(
         raw: raw,
         id: id,
         sensorId: sensorId,
         sensorName: sensorName,
         currentValue: currentValue,
         alertType: alertType,
         createdAt: createdAt,
         normalRange: normalRange,
         patientId: patientId,
         patientName: patientName,
       );

  factory DoctorAlertModel.fromJson(Map<String, dynamic> json) {
    return DoctorAlertModel(
      raw: json,
      id: json['id'] ?? 0,
      sensorId: json['sensorId'] ?? 0,
      sensorName: json['sensorName'] ?? '',
      currentValue: (json['currentValue'] ?? '').toString(),
      alertType: json['alertType']?.toString() ?? 'INFO',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      normalRange: json['normalRange'] is Map<String, dynamic>
          ? json['normalRange']
          : null,
      patientId: json['patientId'],
      patientName: json['patientName']?.toString(),
    );
  }
}
