import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/patient/domain/entities/doctor_entity.dart';
import 'package:murafik/feature/patient/domain/repositories/patient_repository.dart';

class GetDoctorUsecase {
  final PatientRepository repository;

  GetDoctorUsecase(this.repository);

  Future<Either<Failure, DoctorEntity>> call() {
    return repository.getDoctor();
  }
}
