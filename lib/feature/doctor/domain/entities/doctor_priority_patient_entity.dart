class DoctorPriorityAlertEntity {
  final String sensorName;
  final String currentValue;
  final String alertType;
  final DateTime? createdAt;

  DoctorPriorityAlertEntity({
    required this.sensorName,
    required this.currentValue,
    required this.alertType,
    required this.createdAt,
  });
}

class DoctorPriorityPatientEntity {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final int alertsToday;
  final int highAlertsToday;
  final int lowAlertsToday;
  final DoctorPriorityAlertEntity? latestAlert;

  DoctorPriorityPatientEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.alertsToday,
    required this.highAlertsToday,
    required this.lowAlertsToday,
    required this.latestAlert,
  });
}
