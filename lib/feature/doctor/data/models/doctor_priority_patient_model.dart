import 'package:murafik/feature/doctor/domain/entities/doctor_priority_patient_entity.dart';

class DoctorPriorityAlertModel extends DoctorPriorityAlertEntity {
  DoctorPriorityAlertModel({
    required String sensorName,
    required String currentValue,
    required String alertType,
    required DateTime? createdAt,
  }) : super(
         sensorName: sensorName,
         currentValue: currentValue,
         alertType: alertType,
         createdAt: createdAt,
       );

  factory DoctorPriorityAlertModel.fromJson(Map<String, dynamic> json) {
    return DoctorPriorityAlertModel(
      sensorName: json['sensorName'] ?? '',
      currentValue: (json['currentValue'] ?? '').toString(),
      alertType: json['alertType']?.toString() ?? 'INFO',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }
}

class DoctorPriorityPatientModel extends DoctorPriorityPatientEntity {
  DoctorPriorityPatientModel({
    required int id,
    required String name,
    required int age,
    required String gender,
    required String phone,
    required int alertsToday,
    required int highAlertsToday,
    required int lowAlertsToday,
    required DoctorPriorityAlertModel? latestAlert,
  }) : super(
         id: id,
         name: name,
         age: age,
         gender: gender,
         phone: phone,
         alertsToday: alertsToday,
         highAlertsToday: highAlertsToday,
         lowAlertsToday: lowAlertsToday,
         latestAlert: latestAlert,
       );

  factory DoctorPriorityPatientModel.fromJson(Map<String, dynamic> json) {
    final latest = json['latestAlert'];
    return DoctorPriorityPatientModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'N/A',
      phone: json['phone'] ?? '',
      alertsToday: json['alertsToday'] ?? 0,
      highAlertsToday: json['highAlertsToday'] ?? 0,
      lowAlertsToday: json['lowAlertsToday'] ?? 0,
      latestAlert: latest is Map<String, dynamic>
          ? DoctorPriorityAlertModel.fromJson(latest)
          : null,
    );
  }
}
