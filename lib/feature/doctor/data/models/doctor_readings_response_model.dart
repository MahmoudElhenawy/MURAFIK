import 'package:murafik/feature/doctor/data/models/doctor_reading_model.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_readings_response_entity.dart';

class DoctorReadingsResponseModel extends DoctorReadingsResponseEntity {
  DoctorReadingsResponseModel({
    required int patientId,
    required String patientName,
    required int count,
    required List<DoctorReadingModel> readings,
  }) : super(
         patientId: patientId,
         patientName: patientName,
         count: count,
         readings: readings,
       );

  factory DoctorReadingsResponseModel.fromJson(Map<String, dynamic> json) {
    final readingsJson = json['readings'];
    final readings = readingsJson is List
        ? readingsJson
              .whereType<Map<String, dynamic>>()
              .map(DoctorReadingModel.fromJson)
              .toList()
        : <DoctorReadingModel>[];

    return DoctorReadingsResponseModel(
      patientId: json['patientId'] ?? 0,
      patientName: json['patientName'] ?? '',
      count: json['count'] ?? readings.length,
      readings: readings,
    );
  }
}
