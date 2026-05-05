import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_patients_response_entity.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';

class GetDoctorPatientsUsecase {
  final DoctorRepository repository;

  GetDoctorPatientsUsecase(this.repository);

  Future<Either<Failure, DoctorPatientsResponseEntity>> call() {
    return repository.getPatients();
  }
}
