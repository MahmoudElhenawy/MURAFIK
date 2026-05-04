import 'package:murafik/feature/auth/data/models/user_model.dart';
import 'package:murafik/feature/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  AuthResponseModel({
    required bool success,
    required String message,
    String? accessToken,
    required DateTime expiresAt,
    required UserModel user,
  }) : super(
         success: success,
         message: message,
         accessToken: accessToken,
         expiresAt: expiresAt,
         user: user,
       );

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      accessToken: json['accessToken'],
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'].toString())
          : DateTime.now(),
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'accessToken': accessToken,
      'expiresAt': expiresAt.toIso8601String(),
      'user': (user as UserModel).toJson(),
    };
  }
}
