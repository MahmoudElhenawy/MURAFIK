import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/doctor/data/datasources/doctor_remote_datasource.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_all_alerts_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_alerts_response_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_info_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_patients_response_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_priority_patients_response_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_readings_response_entity.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, DoctorInfoEntity>> getMyInfo() async {
    try {
      final result = await remoteDataSource.getMyInfo();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorPatientsResponseEntity>> getPatients() async {
    try {
      final result = await remoteDataSource.getPatients();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorReadingsResponseEntity>> getPatientReadings({
    required int patientId,
    required int limit,
  }) async {
    try {
      final result = await remoteDataSource.getPatientReadings(
        patientId: patientId,
        limit: limit,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorAlertsResponseEntity>> getPatientAlerts({
    required int patientId,
    required int limit,
  }) async {
    try {
      final result = await remoteDataSource.getPatientAlerts(
        patientId: patientId,
        limit: limit,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorAllAlertsEntity>> getAllAlerts({
    required int hours,
  }) async {
    try {
      final result = await remoteDataSource.getAllAlerts(hours: hours);
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorPriorityPatientsResponseEntity>>
  getPriorityPatients({required int alertThreshold}) async {
    try {
      final result = await remoteDataSource.getPriorityPatients(
        alertThreshold: alertThreshold,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
