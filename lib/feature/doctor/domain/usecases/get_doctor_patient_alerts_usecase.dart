import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_alerts_response_entity.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';

class GetDoctorPatientAlertsUsecase {
  final DoctorRepository repository;

  GetDoctorPatientAlertsUsecase(this.repository);

  Future<Either<Failure, DoctorAlertsResponseEntity>> call({
    required int patientId,
    required int limit,
  }) {
    return repository.getPatientAlerts(patientId: patientId, limit: limit);
  }
}
