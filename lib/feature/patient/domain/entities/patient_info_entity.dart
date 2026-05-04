import 'package:murafik/feature/patient/domain/entities/doctor_entity.dart';

class PatientInfoEntity {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String address;
  final String phone;
  final DoctorEntity? doctor;

  PatientInfoEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.phone,
    this.doctor,
  });
}
