import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_stats_entity.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';

class GetSupervisorPatientStatsUsecase {
  final SupervisorRepository repository;

  GetSupervisorPatientStatsUsecase(this.repository);

  Future<Either<Failure, SupervisorStatsEntity>> call() {
    return repository.getPatientStats();
  }
}
