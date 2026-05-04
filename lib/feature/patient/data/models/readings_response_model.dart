import 'package:murafik/feature/patient/data/models/patient_reading_model.dart';
import 'package:murafik/feature/patient/domain/entities/readings_response_entity.dart';

class ReadingsResponseModel extends ReadingsResponseEntity {
  ReadingsResponseModel({
    required int count,
    required DateTime? from,
    required DateTime? to,
    required List<PatientReadingModel> readings,
  }) : super(count: count, from: from, to: to, readings: readings);

  factory ReadingsResponseModel.fromJson(Map<String, dynamic> json) {
    final dateRange = json['dateRange'] as Map<String, dynamic>?;
    final from = dateRange?['from'] != null
        ? DateTime.tryParse(dateRange?['from'].toString() ?? '')
        : null;
    final to = dateRange?['to'] != null
        ? DateTime.tryParse(dateRange?['to'].toString() ?? '')
        : null;

    final readingsJson = json['readings'];
    final readings = readingsJson is List
        ? readingsJson
              .whereType<Map<String, dynamic>>()
              .map(PatientReadingModel.fromJson)
              .toList()
        : <PatientReadingModel>[];

    return ReadingsResponseModel(
      count: json['count'] ?? readings.length,
      from: from,
      to: to,
      readings: readings,
    );
  }
}
