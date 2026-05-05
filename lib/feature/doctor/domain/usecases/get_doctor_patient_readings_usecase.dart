import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_readings_response_entity.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';

class GetDoctorPatientReadingsUsecase {
  final DoctorRepository repository;

  GetDoctorPatientReadingsUsecase(this.repository);

  Future<Either<Failure, DoctorReadingsResponseEntity>> call({
    required int patientId,
    required int limit,
  }) {
    return repository.getPatientReadings(patientId: patientId, limit: limit);
  }
}
