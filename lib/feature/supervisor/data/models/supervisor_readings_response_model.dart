import 'package:murafik/feature/supervisor/data/models/supervisor_reading_model.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_readings_response_entity.dart';

class SupervisorReadingsResponseModel extends SupervisorReadingsResponseEntity {
  SupervisorReadingsResponseModel({
    required int patientId,
    required int count,
    required List<SupervisorReadingModel> readings,
  }) : super(patientId: patientId, count: count, readings: readings);

  factory SupervisorReadingsResponseModel.fromJson(Map<String, dynamic> json) {
    final readingsJson = json['readings'];
    final readings = readingsJson is List
        ? readingsJson
              .whereType<Map<String, dynamic>>()
              .map(SupervisorReadingModel.fromJson)
              .toList()
        : <SupervisorReadingModel>[];

    return SupervisorReadingsResponseModel(
      patientId: json['patientId'] ?? 0,
      count: json['count'] ?? readings.length,
      readings: readings,
    );
  }
}
