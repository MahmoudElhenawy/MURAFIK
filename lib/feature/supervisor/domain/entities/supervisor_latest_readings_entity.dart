import 'package:murafik/feature/supervisor/domain/entities/supervisor_reading_entity.dart';

class SupervisorLatestReadingsEntity {
  final int patientId;
  final int deviceId;
  final String deviceSerial;
  final int sensorsCount;
  final List<SupervisorReadingEntity> readings;

  SupervisorLatestReadingsEntity({
    required this.patientId,
    required this.deviceId,
    required this.deviceSerial,
    required this.sensorsCount,
    required this.readings,
  });
}
