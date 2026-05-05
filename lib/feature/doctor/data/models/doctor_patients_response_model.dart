import 'package:murafik/feature/doctor/data/models/doctor_patient_model.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_patients_response_entity.dart';

class DoctorPatientsResponseModel extends DoctorPatientsResponseEntity {
  DoctorPatientsResponseModel({
    required int doctorId,
    required int patientsCount,
    required int activePatients,
    required int patientsWithAlertsToday,
    required List<DoctorPatientModel> patients,
  }) : super(
         doctorId: doctorId,
         patientsCount: patientsCount,
         activePatients: activePatients,
         patientsWithAlertsToday: patientsWithAlertsToday,
         patients: patients,
       );

  factory DoctorPatientsResponseModel.fromJson(Map<String, dynamic> json) {
    final patientsJson = json['patients'];
    final patients = patientsJson is List
        ? patientsJson
              .whereType<Map<String, dynamic>>()
              .map(DoctorPatientModel.fromJson)
              .toList()
        : <DoctorPatientModel>[];

    return DoctorPatientsResponseModel(
      doctorId: json['doctorId'] ?? 0,
      patientsCount: json['patientsCount'] ?? patients.length,
      activePatients: json['activePatients'] ?? 0,
      patientsWithAlertsToday: json['patientsWithAlertsToday'] ?? 0,
      patients: patients,
    );
  }
}
