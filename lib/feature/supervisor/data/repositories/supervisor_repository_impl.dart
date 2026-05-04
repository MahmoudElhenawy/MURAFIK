import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/supervisor/data/datasources/supervisor_remote_datasource.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_alerts_response_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_info_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_latest_readings_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_patient_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_readings_response_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_stats_entity.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';

class SupervisorRepositoryImpl implements SupervisorRepository {
  final SupervisorRemoteDataSource remoteDataSource;

  SupervisorRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, SupervisorInfoEntity>> getMyInfo() async {
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
  Future<Either<Failure, SupervisorPatientEntity>> getPatient() async {
    try {
      final result = await remoteDataSource.getPatient();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SupervisorReadingsResponseEntity>> getPatientReadings({
    required int limit,
  }) async {
    try {
      final result = await remoteDataSource.getPatientReadings(limit: limit);
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SupervisorAlertsResponseEntity>> getPatientAlerts({
    required int limit,
  }) async {
    try {
      final result = await remoteDataSource.getPatientAlerts(limit: limit);
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SupervisorLatestReadingsEntity>>
  getPatientLatestReadings() async {
    try {
      final result = await remoteDataSource.getPatientLatestReadings();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SupervisorStatsEntity>> getPatientStats() async {
    try {
      final result = await remoteDataSource.getPatientStats();
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
