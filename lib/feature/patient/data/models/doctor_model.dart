import 'package:murafik/feature/patient/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  DoctorModel({
    required int id,
    required String name,
    required String phone,
    required String specialization,
    int? totalPatients,
  }) : super(
         id: id,
         name: name,
         phone: phone,
         specialization: specialization,
         totalPatients: totalPatients,
       );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      specialization: json['specialization'] ?? 'N/A',
      totalPatients: json['totalPatients'],
    );
  }
}
