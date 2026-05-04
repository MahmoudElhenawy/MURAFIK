import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_alerts_response_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_info_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_latest_readings_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_patient_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_readings_response_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_stats_entity.dart';

abstract class SupervisorRepository {
  Future<Either<Failure, SupervisorInfoEntity>> getMyInfo();

  Future<Either<Failure, SupervisorPatientEntity>> getPatient();

  Future<Either<Failure, SupervisorReadingsResponseEntity>> getPatientReadings({
    required int limit,
  });

  Future<Either<Failure, SupervisorAlertsResponseEntity>> getPatientAlerts({
    required int limit,
  });

  Future<Either<Failure, SupervisorLatestReadingsEntity>>
  getPatientLatestReadings();

  Future<Either<Failure, SupervisorStatsEntity>> getPatientStats();
}
