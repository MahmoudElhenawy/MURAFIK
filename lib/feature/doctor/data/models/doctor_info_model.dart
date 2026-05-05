import 'package:murafik/feature/doctor/domain/entities/doctor_info_entity.dart';

class DoctorInfoModel extends DoctorInfoEntity {
  DoctorInfoModel({
    required int id,
    required String name,
    required String phone,
    required String specialization,
    required int patientsCount,
    required int activePatientsToday,
  }) : super(
         id: id,
         name: name,
         phone: phone,
         specialization: specialization,
         patientsCount: patientsCount,
         activePatientsToday: activePatientsToday,
       );

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    return DoctorInfoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      specialization: json['specialization'] ?? 'N/A',
      patientsCount: json['patientsCount'] ?? 0,
      activePatientsToday: json['activePatientsToday'] ?? 0,
    );
  }
}
