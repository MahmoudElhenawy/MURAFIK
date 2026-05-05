import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_info_entity.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';

class GetDoctorMyInfoUsecase {
  final DoctorRepository repository;

  GetDoctorMyInfoUsecase(this.repository);

  Future<Either<Failure, DoctorInfoEntity>> call() {
    return repository.getMyInfo();
  }
}
