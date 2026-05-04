import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/patient/domain/entities/patient_info_entity.dart';
import 'package:murafik/feature/patient/domain/repositories/patient_repository.dart';

class GetMyInfoUsecase {
  final PatientRepository repository;

  GetMyInfoUsecase(this.repository);

  Future<Either<Failure, PatientInfoEntity>> call() {
    return repository.getMyInfo();
  }
}
