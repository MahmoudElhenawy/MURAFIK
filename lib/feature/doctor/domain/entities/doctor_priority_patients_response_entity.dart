import 'package:murafik/feature/doctor/domain/entities/doctor_priority_patient_entity.dart';

class DoctorPriorityPatientsResponseEntity {
  final int threshold;
  final int count;
  final List<DoctorPriorityPatientEntity> patients;

  DoctorPriorityPatientsResponseEntity({
    required this.threshold,
    required this.count,
    required this.patients,
  });
}
