import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_alerts_response_entity.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';

class GetSupervisorPatientAlertsUsecase {
  final SupervisorRepository repository;

  GetSupervisorPatientAlertsUsecase(this.repository);

  Future<Either<Failure, SupervisorAlertsResponseEntity>> call({
    required int limit,
  }) {
    return repository.getPatientAlerts(limit: limit);
  }
}
