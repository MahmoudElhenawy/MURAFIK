import 'package:murafik/feature/auth/domain/entities/user_entity.dart';

class AuthResponseEntity {
  final bool success;
  final String message;
  final String? accessToken;
  final DateTime expiresAt;
  final UserEntity user;

  AuthResponseEntity({
    required this.success,
    required this.message,
    this.accessToken,
    required this.expiresAt,
    required this.user,
  });
}
