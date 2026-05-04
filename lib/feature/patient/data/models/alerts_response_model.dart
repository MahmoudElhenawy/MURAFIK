import 'package:murafik/feature/patient/data/models/patient_alert_model.dart';
import 'package:murafik/feature/patient/domain/entities/alerts_response_entity.dart';

class AlertsResponseModel extends AlertsResponseEntity {
  AlertsResponseModel({
    required int count,
    required int highAlerts,
    required int lowAlerts,
    required List<PatientAlertModel> alerts,
  }) : super(
         count: count,
         highAlerts: highAlerts,
         lowAlerts: lowAlerts,
         alerts: alerts,
       );

  factory AlertsResponseModel.fromJson(Map<String, dynamic> json) {
    final alertsJson = json['alerts'];
    final alerts = alertsJson is List
        ? alertsJson
              .whereType<Map<String, dynamic>>()
              .map(PatientAlertModel.fromJson)
              .toList()
        : <PatientAlertModel>[];

    return AlertsResponseModel(
      count: json['count'] ?? alerts.length,
      highAlerts: json['highAlerts'] ?? 0,
      lowAlerts: json['lowAlerts'] ?? 0,
      alerts: alerts,
    );
  }
}
