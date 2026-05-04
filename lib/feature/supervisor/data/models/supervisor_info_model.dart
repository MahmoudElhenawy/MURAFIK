import 'package:murafik/feature/supervisor/data/models/supervisor_patient_brief_model.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_info_entity.dart';

class SupervisorInfoModel extends SupervisorInfoEntity {
  SupervisorInfoModel({
    required int id,
    required String name,
    required String phone,
    required String role,
    SupervisorPatientBriefModel? patient,
  }) : super(id: id, name: name, phone: phone, role: role, patient: patient);

  factory SupervisorInfoModel.fromJson(Map<String, dynamic> json) {
    final patientJson = json['patient'];
    return SupervisorInfoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      patient: patientJson is Map<String, dynamic>
          ? SupervisorPatientBriefModel.fromJson(patientJson)
          : null,
    );
  }
}
