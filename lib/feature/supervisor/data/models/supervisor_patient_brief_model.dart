import 'package:murafik/feature/supervisor/domain/entities/supervisor_patient_brief_entity.dart';

class SupervisorPatientBriefModel extends SupervisorPatientBriefEntity {
  SupervisorPatientBriefModel({
    required int id,
    required String name,
    required int age,
  }) : super(id: id, name: name, age: age);

  factory SupervisorPatientBriefModel.fromJson(Map<String, dynamic> json) {
    return SupervisorPatientBriefModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
    );
  }
}
