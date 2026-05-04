import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_readings_response_entity.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';

class GetSupervisorPatientReadingsUsecase {
  final SupervisorRepository repository;

  GetSupervisorPatientReadingsUsecase(this.repository);

  Future<Either<Failure, SupervisorReadingsResponseEntity>> call({
    required int limit,
  }) {
    return repository.getPatientReadings(limit: limit);
  }
}
