import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:murafik/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:murafik/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthResponseEntity>> register({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      final result = await remoteDataSource.register(
        username: username,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // TODO: Implement logout logic
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
