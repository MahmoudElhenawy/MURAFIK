import 'package:murafik/feature/doctor/data/models/doctor_alert_model.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_all_alerts_entity.dart';

class DoctorAllAlertsModel extends DoctorAllAlertsEntity {
  DoctorAllAlertsModel({
    required String timeRange,
    required int totalAlerts,
    required int patientsWithAlerts,
    required int highPriorityPatients,
    required List<DoctorAlertSummaryModel> summary,
    required List<DoctorAlertModel> allAlerts,
  }) : super(
         timeRange: timeRange,
         totalAlerts: totalAlerts,
         patientsWithAlerts: patientsWithAlerts,
         highPriorityPatients: highPriorityPatients,
         summary: summary,
         allAlerts: allAlerts,
       );

  factory DoctorAllAlertsModel.fromJson(Map<String, dynamic> json) {
    final summaryJson = json['summary'];
    final summary = summaryJson is List
        ? summaryJson
              .whereType<Map<String, dynamic>>()
              .map(DoctorAlertSummaryModel.fromJson)
              .toList()
        : <DoctorAlertSummaryModel>[];

    final alertsJson = json['allAlerts'];
    final allAlerts = alertsJson is List
        ? alertsJson
              .whereType<Map<String, dynamic>>()
              .map(DoctorAlertModel.fromJson)
              .toList()
        : <DoctorAlertModel>[];

    return DoctorAllAlertsModel(
      timeRange: json['timeRange'] ?? '',
      totalAlerts: json['totalAlerts'] ?? allAlerts.length,
      patientsWithAlerts: json['patientsWithAlerts'] ?? 0,
      highPriorityPatients: json['highPriorityPatients'] ?? 0,
      summary: summary,
      allAlerts: allAlerts,
    );
  }
}

class DoctorAlertSummaryModel extends DoctorAlertSummaryEntity {
  DoctorAlertSummaryModel({
    required int patientId,
    required String patientName,
    required int alertCount,
    required int highAlerts,
    required int lowAlerts,
    required DoctorAlertModel? latestAlert,
  }) : super(
         patientId: patientId,
         patientName: patientName,
         alertCount: alertCount,
         highAlerts: highAlerts,
         lowAlerts: lowAlerts,
         latestAlert: latestAlert,
       );

  factory DoctorAlertSummaryModel.fromJson(Map<String, dynamic> json) {
    final latest = json['latestAlert'];
    return DoctorAlertSummaryModel(
      patientId: json['patientId'] ?? 0,
      patientName: json['patientName'] ?? '',
      alertCount: json['alertCount'] ?? 0,
      highAlerts: json['highAlerts'] ?? 0,
      lowAlerts: json['lowAlerts'] ?? 0,
      latestAlert: latest is Map<String, dynamic>
          ? DoctorAlertModel.fromJson(latest)
          : null,
    );
  }
}
