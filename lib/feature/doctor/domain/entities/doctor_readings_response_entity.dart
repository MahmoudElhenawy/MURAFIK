import 'package:murafik/feature/doctor/domain/entities/doctor_reading_entity.dart';

class DoctorReadingsResponseEntity {
  final int patientId;
  final String patientName;
  final int count;
  final List<DoctorReadingEntity> readings;

  DoctorReadingsResponseEntity({
    required this.patientId,
    required this.patientName,
    required this.count,
    required this.readings,
  });
}
