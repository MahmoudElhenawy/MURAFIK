import 'package:murafik/feature/patient/domain/entities/patient_reading_entity.dart';

class ReadingsResponseEntity {
  final int count;
  final DateTime? from;
  final DateTime? to;
  final List<PatientReadingEntity> readings;

  ReadingsResponseEntity({
    required this.count,
    required this.from,
    required this.to,
    required this.readings,
  });
}
