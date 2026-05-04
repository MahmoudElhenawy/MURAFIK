import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/patient/data/datasources/patient_remote_datasource.dart';
import 'package:murafik/feature/patient/domain/entities/alerts_response_entity.dart';
import 'package:murafik/feature/patient/domain/entities/doctor_entity.dart';
import 'package:murafik/feature/patient/domain/entities/message_response_entity.dart';
import 'package:murafik/feature/patient/domain/entities/patient_info_entity.dart';
import 'package:murafik/feature/patient/domain/entities/readings_response_entity.dart';
import 'package:murafik/feature/patient/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PatientInfoEntity>> getMyInfo() async {
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
  Future<Either<Failure, DoctorEntity>> getDoctor() async {
    try {
      final result = await remoteDataSource.getDoctor();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReadingsResponseEntity>> getReadings({
    required int limit,
  }) async {
    try {
      final result = await remoteDataSource.getReadings(limit: limit);
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageResponseEntity>> getLatestReadings() async {
    try {
      final result = await remoteDataSource.getLatestReadings();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AlertsResponseEntity>> getAlerts({
    required int limit,
  }) async {
    try {
      final result = await remoteDataSource.getAlerts(limit: limit);
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageResponseEntity>> getDevice() async {
    try {
      final result = await remoteDataSource.getDevice();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
