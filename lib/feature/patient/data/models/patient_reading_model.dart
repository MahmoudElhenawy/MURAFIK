import 'package:murafik/feature/patient/domain/entities/patient_reading_entity.dart';

class PatientReadingModel extends PatientReadingEntity {
  PatientReadingModel({
    required Map<String, dynamic> raw,
    required String name,
    required String value,
    required String unit,
    required DateTime? createdAt,
  }) : super(
         raw: raw,
         name: name,
         value: value,
         unit: unit,
         createdAt: createdAt,
       );

  factory PatientReadingModel.fromJson(Map<String, dynamic> json) {
    final name =
        (json['sensorName'] ?? json['name'] ?? json['type'] ?? 'Reading')
            .toString();
    final value = (json['value'] ?? json['reading'] ?? json['data'] ?? '')
        .toString();
    final unit = (json['unit'] ?? json['u'] ?? '').toString();
    final createdAtRaw =
        json['timeStamp'] ?? json['createdAt'] ?? json['time'] ?? json['date'];

    return PatientReadingModel(
      raw: json,
      name: name,
      value: value,
      unit: unit,
      createdAt: createdAtRaw != null
          ? DateTime.tryParse(createdAtRaw.toString())
          : null,
    );
  }
}
