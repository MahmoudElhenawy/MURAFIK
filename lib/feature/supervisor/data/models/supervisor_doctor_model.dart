import 'package:murafik/feature/supervisor/domain/entities/supervisor_doctor_entity.dart';

class SupervisorDoctorModel extends SupervisorDoctorEntity {
  SupervisorDoctorModel({
    required int id,
    required String name,
    required String phone,
    required String specialization,
  }) : super(id: id, name: name, phone: phone, specialization: specialization);

  factory SupervisorDoctorModel.fromJson(Map<String, dynamic> json) {
    return SupervisorDoctorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      specialization: json['specialization'] ?? 'N/A',
    );
  }
}
