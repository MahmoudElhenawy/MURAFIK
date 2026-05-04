import 'package:murafik/feature/supervisor/domain/entities/supervisor_alert_entity.dart';

class SupervisorAlertsResponseEntity {
  final int patientId;
  final String? patientName;
  final int count;
  final int highAlerts;
  final int lowAlerts;
  final List<SupervisorAlertEntity> alerts;

  SupervisorAlertsResponseEntity({
    required this.patientId,
    required this.patientName,
    required this.count,
    required this.highAlerts,
    required this.lowAlerts,
    required this.alerts,
  });
}
