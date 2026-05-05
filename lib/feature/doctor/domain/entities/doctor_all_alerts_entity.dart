import 'package:murafik/feature/doctor/domain/entities/doctor_alert_entity.dart';

class DoctorAllAlertsEntity {
  final String timeRange;
  final int totalAlerts;
  final int patientsWithAlerts;
  final int highPriorityPatients;
  final List<DoctorAlertSummaryEntity> summary;
  final List<DoctorAlertEntity> allAlerts;

  DoctorAllAlertsEntity({
    required this.timeRange,
    required this.totalAlerts,
    required this.patientsWithAlerts,
    required this.highPriorityPatients,
    required this.summary,
    required this.allAlerts,
  });
}

class DoctorAlertSummaryEntity {
  final int patientId;
  final String patientName;
  final int alertCount;
  final int highAlerts;
  final int lowAlerts;
  final DoctorAlertEntity? latestAlert;

  DoctorAlertSummaryEntity({
    required this.patientId,
    required this.patientName,
    required this.alertCount,
    required this.highAlerts,
    required this.lowAlerts,
    required this.latestAlert,
  });
}
