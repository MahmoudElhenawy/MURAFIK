import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_priority_patients_response_entity.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';

class GetDoctorPriorityPatientsUsecase {
  final DoctorRepository repository;

  GetDoctorPriorityPatientsUsecase(this.repository);

  Future<Either<Failure, DoctorPriorityPatientsResponseEntity>> call({
    required int alertThreshold,
  }) {
    return repository.getPriorityPatients(alertThreshold: alertThreshold);
  }
}
