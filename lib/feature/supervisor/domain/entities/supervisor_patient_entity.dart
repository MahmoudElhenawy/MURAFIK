import 'package:murafik/feature/supervisor/domain/entities/supervisor_device_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_doctor_entity.dart';

class SupervisorPatientEntity {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String address;
  final SupervisorDoctorEntity? doctor;
  final SupervisorDeviceEntity? device;
  final Map<String, dynamic>? latestReading;
  final int alertCountToday;
  final int totalAlerts;
  final String status;

  SupervisorPatientEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.address,
    this.doctor,
    this.device,
    this.latestReading,
    required this.alertCountToday,
    required this.totalAlerts,
    required this.status,
  });
}
