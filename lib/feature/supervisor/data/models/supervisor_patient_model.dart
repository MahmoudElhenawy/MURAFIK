import 'package:murafik/feature/supervisor/data/models/supervisor_device_model.dart';
import 'package:murafik/feature/supervisor/data/models/supervisor_doctor_model.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_patient_entity.dart';

class SupervisorPatientModel extends SupervisorPatientEntity {
  SupervisorPatientModel({
    required int id,
    required String name,
    required int age,
    required String gender,
    required String phone,
    required String address,
    SupervisorDoctorModel? doctor,
    SupervisorDeviceModel? device,
    Map<String, dynamic>? latestReading,
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
         doctor: doctor,
         device: device,
         latestReading: latestReading,
         alertCountToday: alertCountToday,
         totalAlerts: totalAlerts,
         status: status,
       );

  factory SupervisorPatientModel.fromJson(Map<String, dynamic> json) {
    final doctorJson = json['doctor'];
    final deviceJson = json['device'];
    return SupervisorPatientModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'N/A',
      phone: json['phone'] ?? '',
      address: json['address'] ?? 'N/A',
      doctor: doctorJson is Map<String, dynamic>
          ? SupervisorDoctorModel.fromJson(doctorJson)
          : null,
      device: deviceJson is Map<String, dynamic>
          ? SupervisorDeviceModel.fromJson(deviceJson)
          : null,
      latestReading: json['latestReading'] is Map<String, dynamic>
          ? json['latestReading']
          : null,
      alertCountToday: json['alertCountToday'] ?? 0,
      totalAlerts: json['totalAlerts'] ?? 0,
      status: json['status'] ?? 'N/A',
    );
  }
}
