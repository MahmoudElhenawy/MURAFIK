import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/patient/domain/entities/readings_response_entity.dart';
import 'package:murafik/feature/patient/domain/repositories/patient_repository.dart';

class GetReadingsUsecase {
  final PatientRepository repository;

  GetReadingsUsecase(this.repository);

  Future<Either<Failure, ReadingsResponseEntity>> call({required int limit}) {
    return repository.getReadings(limit: limit);
  }
}
