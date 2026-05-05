import 'package:murafik/feature/doctor/domain/entities/doctor_alert_entity.dart';

class DoctorAlertsResponseEntity {
  final int patientId;
  final String patientName;
  final int count;
  final int highAlerts;
  final int lowAlerts;
  final List<DoctorAlertEntity> alerts;

  DoctorAlertsResponseEntity({
    required this.patientId,
    required this.patientName,
    required this.count,
    required this.highAlerts,
    required this.lowAlerts,
    required this.alerts,
  });
}
