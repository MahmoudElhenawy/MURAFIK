import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/patient/domain/entities/alerts_response_entity.dart';
import 'package:murafik/feature/patient/domain/repositories/patient_repository.dart';

class GetAlertsUsecase {
  final PatientRepository repository;

  GetAlertsUsecase(this.repository);

  Future<Either<Failure, AlertsResponseEntity>> call({required int limit}) {
    return repository.getAlerts(limit: limit);
  }
}
