import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_latest_readings_entity.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';

class GetSupervisorPatientLatestReadingsUsecase {
  final SupervisorRepository repository;

  GetSupervisorPatientLatestReadingsUsecase(this.repository);

  Future<Either<Failure, SupervisorLatestReadingsEntity>> call() {
    return repository.getPatientLatestReadings();
  }
}
