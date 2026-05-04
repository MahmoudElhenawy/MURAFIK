import 'package:dio/dio.dart';
import 'package:murafik/feature/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String role,
  });

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'http://murafik.runasp.net/api/auth';

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthResponseModel> register({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final response = await dio.post(
      '$baseUrl/register',
      data: {
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
        'role': role,
      },
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to register' : message);
  }

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '$baseUrl/login',
      data: {'email': email, 'password': password},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to login' : message);
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String) {
        return message;
      }

      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        return errors.values
            .expand((value) => value is List ? value : [value])
            .map((value) => value.toString())
            .join(' ');
      }
    }

    if (data is String) {
      return data;
    }

    return '';
  }
}
