import 'package:murafik/feature/patient/data/models/doctor_model.dart';
import 'package:murafik/feature/patient/domain/entities/patient_info_entity.dart';

class PatientInfoModel extends PatientInfoEntity {
  PatientInfoModel({
    required int id,
    required String name,
    required int age,
    required String gender,
    required String address,
    required String phone,
    DoctorModel? doctor,
  }) : super(
         id: id,
         name: name,
         age: age,
         gender: gender,
         address: address,
         phone: phone,
         doctor: doctor,
       );

  factory PatientInfoModel.fromJson(Map<String, dynamic> json) {
    final doctorJson = json['doctor'];
    return PatientInfoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'N/A',
      address: json['address'] ?? 'N/A',
      phone: json['phone'] ?? '',
      doctor: doctorJson is Map<String, dynamic>
          ? DoctorModel.fromJson(doctorJson)
          : null,
    );
  }
}
