import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_patient_entity.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';

class GetSupervisorPatientUsecase {
  final SupervisorRepository repository;

  GetSupervisorPatientUsecase(this.repository);

  Future<Either<Failure, SupervisorPatientEntity>> call() {
    return repository.getPatient();
  }
}
