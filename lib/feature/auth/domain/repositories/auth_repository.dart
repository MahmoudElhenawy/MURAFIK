import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/auth/domain/entities/auth_response_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseEntity>> register({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String role,
  });

  Future<Either<Failure, AuthResponseEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
}
