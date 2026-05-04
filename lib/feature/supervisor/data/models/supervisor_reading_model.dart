import 'package:murafik/feature/supervisor/domain/entities/supervisor_reading_entity.dart';

class SupervisorReadingModel extends SupervisorReadingEntity {
  SupervisorReadingModel({
    required Map<String, dynamic> raw,
    required int id,
    required int sensorId,
    required String sensorName,
    required String unit,
    required String value,
    required DateTime? timeStamp,
    required bool hasAlert,
    String? alertType,
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
       );

  factory SupervisorReadingModel.fromJson(Map<String, dynamic> json) {
    return SupervisorReadingModel(
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
    );
  }
}
