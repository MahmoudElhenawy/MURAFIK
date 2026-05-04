import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/patient/domain/entities/alerts_response_entity.dart';
import 'package:murafik/feature/patient/domain/entities/doctor_entity.dart';
import 'package:murafik/feature/patient/domain/entities/message_response_entity.dart';
import 'package:murafik/feature/patient/domain/entities/patient_info_entity.dart';
import 'package:murafik/feature/patient/domain/entities/readings_response_entity.dart';

abstract class PatientRepository {
  Future<Either<Failure, PatientInfoEntity>> getMyInfo();

  Future<Either<Failure, DoctorEntity>> getDoctor();

  Future<Either<Failure, ReadingsResponseEntity>> getReadings({
    required int limit,
  });

  Future<Either<Failure, MessageResponseEntity>> getLatestReadings();

  Future<Either<Failure, AlertsResponseEntity>> getAlerts({required int limit});

  Future<Either<Failure, MessageResponseEntity>> getDevice();
}
