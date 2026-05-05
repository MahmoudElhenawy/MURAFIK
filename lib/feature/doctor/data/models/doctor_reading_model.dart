import 'package:murafik/feature/doctor/domain/entities/doctor_reading_entity.dart';

class DoctorReadingModel extends DoctorReadingEntity {
  DoctorReadingModel({
    required Map<String, dynamic> raw,
    required int id,
    required int sensorId,
    required String sensorName,
    required String unit,
    required String value,
    required DateTime? timeStamp,
    required bool hasAlert,
    required String? alertType,
    required Map<String, dynamic>? normalRange,
  }) : super(
         raw: raw,
         id: id,
         sensorId: sensorId,
         sensorName: sensorName,
         unit: unit,
         value: value,
         timeStamp: timeStamp,
         hasAlert: hasAlert,
         alertType: alertType,
         normalRange: normalRange,
       );

  factory DoctorReadingModel.fromJson(Map<String, dynamic> json) {
    return DoctorReadingModel(
      raw: json,
      id: json['id'] ?? 0,
      sensorId: json['sensorId'] ?? 0,
      sensorName: json['sensorName'] ?? '',
      unit: json['unit'] ?? '',
      value: (json['value'] ?? '').toString(),
      timeStamp: json['timeStamp'] != null
          ? DateTime.tryParse(json['timeStamp'].toString())
          : null,
      hasAlert: json['hasAlert'] == true,
      alertType: json['alertType']?.toString(),
      normalRange: json['normalRange'] is Map<String, dynamic>
          ? json['normalRange']
          : null,
    );
  }
}
