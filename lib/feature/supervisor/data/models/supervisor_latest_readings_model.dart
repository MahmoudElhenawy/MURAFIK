import 'package:murafik/feature/supervisor/data/models/supervisor_reading_model.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_latest_readings_entity.dart';

class SupervisorLatestReadingsModel extends SupervisorLatestReadingsEntity {
  SupervisorLatestReadingsModel({
    required int patientId,
    required int deviceId,
    required String deviceSerial,
    required int sensorsCount,
    required List<SupervisorReadingModel> readings,
  }) : super(
         patientId: patientId,
         deviceId: deviceId,
         deviceSerial: deviceSerial,
         sensorsCount: sensorsCount,
         readings: readings,
       );

  factory SupervisorLatestReadingsModel.fromJson(Map<String, dynamic> json) {
    final readingsJson = json['readings'];
    final readings = readingsJson is List
        ? readingsJson
              .whereType<Map<String, dynamic>>()
              .map(SupervisorReadingModel.fromJson)
              .toList()
        : <SupervisorReadingModel>[];

    return SupervisorLatestReadingsModel(
      patientId: json['patientId'] ?? 0,
      deviceId: json['deviceId'] ?? 0,
      deviceSerial: json['deviceSerial'] ?? '',
      sensorsCount: json['sensorsCount'] ?? readings.length,
      readings: readings,
    );
  }
}
