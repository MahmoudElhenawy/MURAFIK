import 'package:dartz/dartz.dart';
import 'package:murafik/core/errors/failures.dart';
import 'package:murafik/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:murafik/feature/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, AuthResponseEntity>> call({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) {
    return repository.register(
      username: username,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );
  }
}
