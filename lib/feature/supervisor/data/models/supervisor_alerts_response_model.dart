import 'package:murafik/feature/supervisor/data/models/supervisor_alert_model.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_alerts_response_entity.dart';

class SupervisorAlertsResponseModel extends SupervisorAlertsResponseEntity {
  SupervisorAlertsResponseModel({
    required int patientId,
    required String? patientName,
    required int count,
    required int highAlerts,
    required int lowAlerts,
    required List<SupervisorAlertModel> alerts,
  }) : super(
         patientId: patientId,
         patientName: patientName,
         count: count,
         highAlerts: highAlerts,
         lowAlerts: lowAlerts,
         alerts: alerts,
       );

  factory SupervisorAlertsResponseModel.fromJson(Map<String, dynamic> json) {
    final alertsJson = json['alerts'];
    final alerts = alertsJson is List
        ? alertsJson
              .whereType<Map<String, dynamic>>()
              .map(SupervisorAlertModel.fromJson)
              .toList()
        : <SupervisorAlertModel>[];

    return SupervisorAlertsResponseModel(
      patientId: json['patientId'] ?? 0,
      patientName: json['patientName']?.toString(),
      count: json['count'] ?? alerts.length,
      highAlerts: json['highAlerts'] ?? 0,
      lowAlerts: json['lowAlerts'] ?? 0,
      alerts: alerts,
    );
  }
}
