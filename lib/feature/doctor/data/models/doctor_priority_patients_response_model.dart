import 'package:murafik/feature/doctor/data/models/doctor_priority_patient_model.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_priority_patients_response_entity.dart';

class DoctorPriorityPatientsResponseModel
    extends DoctorPriorityPatientsResponseEntity {
  DoctorPriorityPatientsResponseModel({
    required int threshold,
    required int count,
    required List<DoctorPriorityPatientModel> patients,
  }) : super(threshold: threshold, count: count, patients: patients);

  factory DoctorPriorityPatientsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final patientsJson = json['patients'];
    final patients = patientsJson is List
        ? patientsJson
              .whereType<Map<String, dynamic>>()
              .map(DoctorPriorityPatientModel.fromJson)
              .toList()
        : <DoctorPriorityPatientModel>[];

    return DoctorPriorityPatientsResponseModel(
      threshold: json['threshold'] ?? 0,
      count: json['count'] ?? patients.length,
      patients: patients,
    );
  }
}
