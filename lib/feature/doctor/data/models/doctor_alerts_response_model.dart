import 'package:murafik/feature/doctor/data/models/doctor_alert_model.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_alerts_response_entity.dart';

class DoctorAlertsResponseModel extends DoctorAlertsResponseEntity {
  DoctorAlertsResponseModel({
    required int patientId,
    required String patientName,
    required int count,
    required int highAlerts,
    required int lowAlerts,
    required List<DoctorAlertModel> alerts,
  }) : super(
         patientId: patientId,
         patientName: patientName,
         count: count,
         highAlerts: highAlerts,
         lowAlerts: lowAlerts,
         alerts: alerts,
       );

  factory DoctorAlertsResponseModel.fromJson(Map<String, dynamic> json) {
    final alertsJson = json['alerts'];
    final alerts = alertsJson is List
        ? alertsJson
              .whereType<Map<String, dynamic>>()
              .map(DoctorAlertModel.fromJson)
              .toList()
        : <DoctorAlertModel>[];

    return DoctorAlertsResponseModel(
      patientId: json['patientId'] ?? 0,
      patientName: json['patientName'] ?? '',
      count: json['count'] ?? alerts.length,
      highAlerts: json['highAlerts'] ?? 0,
      lowAlerts: json['lowAlerts'] ?? 0,
      alerts: alerts,
    );
  }
}
