import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_all_alerts_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_alerts_response_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_info_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_patients_response_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_priority_patients_response_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_readings_response_entity.dart';

abstract class DoctorRepository {
  Future<Either<Failure, DoctorInfoEntity>> getMyInfo();

  Future<Either<Failure, DoctorPatientsResponseEntity>> getPatients();

  Future<Either<Failure, DoctorReadingsResponseEntity>> getPatientReadings({
    required int patientId,
    required int limit,
  });

  Future<Either<Failure, DoctorAlertsResponseEntity>> getPatientAlerts({
    required int patientId,
    required int limit,
  });

  Future<Either<Failure, DoctorAllAlertsEntity>> getAllAlerts({
    required int hours,
  });

  Future<Either<Failure, DoctorPriorityPatientsResponseEntity>>
  getPriorityPatients({required int alertThreshold});
}
