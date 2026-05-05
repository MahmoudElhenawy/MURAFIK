import 'package:murafik/feature/doctor/domain/entities/doctor_patient_entity.dart';

class DoctorPatientModel extends DoctorPatientEntity {
  DoctorPatientModel({
    required int id,
    required String name,
    required int age,
    required String gender,
    required String phone,
    required String address,
    required String? deviceSerial,
    required int supervisorCount,
    required Map<String, dynamic>? latestReading,
    required int alertCountToday,
    required int totalAlerts,
    required String status,
  }) : super(
         id: id,
         name: name,
         age: age,
         gender: gender,
         phone: phone,
         address: address,
         deviceSerial: deviceSerial,
         supervisorCount: supervisorCount,
         latestReading: latestReading,
         alertCountToday: alertCountToday,
         totalAlerts: totalAlerts,
         status: status,
       );

  factory DoctorPatientModel.fromJson(Map<String, dynamic> json) {
    return DoctorPatientModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'N/A',
      phone: json['phone'] ?? '',
      address: json['address'] ?? 'N/A',
      deviceSerial: json['deviceSerial']?.toString(),
      supervisorCount: json['supervisorCount'] ?? 0,
      latestReading: json['latestReading'] is Map<String, dynamic>
          ? json['latestReading']
          : null,
      alertCountToday: json['alertCountToday'] ?? 0,
      totalAlerts: json['totalAlerts'] ?? 0,
      status: json['status'] ?? 'N/A',
    );
  }
}
