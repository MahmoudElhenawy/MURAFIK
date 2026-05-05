import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_all_alerts_entity.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';

class GetDoctorAllAlertsUsecase {
  final DoctorRepository repository;

  GetDoctorAllAlertsUsecase(this.repository);

  Future<Either<Failure, DoctorAllAlertsEntity>> call({required int hours}) {
    return repository.getAllAlerts(hours: hours);
  }
}
