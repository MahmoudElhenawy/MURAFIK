import 'package:murafik/feature/supervisor/domain/entities/supervisor_patient_brief_entity.dart';

class SupervisorInfoEntity {
  final int id;
  final String name;
  final String phone;
  final String role;
  final SupervisorPatientBriefEntity? patient;

  SupervisorInfoEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.patient,
  });
}
