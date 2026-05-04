import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/patient/domain/entities/message_response_entity.dart';
import 'package:murafik/feature/patient/domain/repositories/patient_repository.dart';

class GetDeviceUsecase {
  final PatientRepository repository;

  GetDeviceUsecase(this.repository);

  Future<Either<Failure, MessageResponseEntity>> call() {
    return repository.getDevice();
  }
}
