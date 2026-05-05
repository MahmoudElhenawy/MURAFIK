import 'package:murafik/feature/doctor/domain/entities/doctor_patient_entity.dart';

class DoctorPatientsResponseEntity {
  final int doctorId;
  final int patientsCount;
  final int activePatients;
  final int patientsWithAlertsToday;
  final List<DoctorPatientEntity> patients;

  DoctorPatientsResponseEntity({
    required this.doctorId,
    required this.patientsCount,
    required this.activePatients,
    required this.patientsWithAlertsToday,
    required this.patients,
  });
}
