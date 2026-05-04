import 'package:murafik/feature/supervisor/domain/entities/supervisor_reading_entity.dart';

class SupervisorReadingsResponseEntity {
  final int patientId;
  final int count;
  final List<SupervisorReadingEntity> readings;

  SupervisorReadingsResponseEntity({
    required this.patientId,
    required this.count,
    required this.readings,
  });
}
