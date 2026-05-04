import 'package:murafik/feature/patient/domain/entities/patient_alert_entity.dart';

class AlertsResponseEntity {
  final int count;
  final int highAlerts;
  final int lowAlerts;
  final List<PatientAlertEntity> alerts;

  AlertsResponseEntity({
    required this.count,
    required this.highAlerts,
    required this.lowAlerts,
    required this.alerts,
  });
}
