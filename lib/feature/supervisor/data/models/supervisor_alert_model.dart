import 'package:murafik/feature/supervisor/domain/entities/supervisor_alert_entity.dart';

class SupervisorAlertModel extends SupervisorAlertEntity {
  SupervisorAlertModel({
    required Map<String, dynamic> raw,
    required int id,
    required int sensorId,
    required String sensorName,
    required String currentValue,
    required String alertType,
    required DateTime? createdAt,
    String? patientName,
  }) : super(
         raw: raw,
         id: id,
         sensorId: sensorId,
         sensorName: sensorName,
         currentValue: currentValue,
         alertType: alertType,
         createdAt: createdAt,
         patientName: patientName,
       );

  factory SupervisorAlertModel.fromJson(Map<String, dynamic> json) {
    return SupervisorAlertModel(
      raw: json,
      id: json['id'] ?? 0,
      sensorId: json['sensorId'] ?? 0,
      sensorName: json['sensorName'] ?? '',
      currentValue: (json['currentValue'] ?? '').toString(),
      alertType: json['alertType']?.toString() ?? 'INFO',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      patientName: json['patientName']?.toString(),
    );
  }
}
