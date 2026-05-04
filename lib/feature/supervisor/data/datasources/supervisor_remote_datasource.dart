import 'package:dio/dio.dart';
import 'package:murafik/feature/supervisor/data/models/supervisor_alerts_response_model.dart';
import 'package:murafik/feature/supervisor/data/models/supervisor_info_model.dart';
import 'package:murafik/feature/supervisor/data/models/supervisor_latest_readings_model.dart';
import 'package:murafik/feature/supervisor/data/models/supervisor_patient_model.dart';
import 'package:murafik/feature/supervisor/data/models/supervisor_readings_response_model.dart';
import 'package:murafik/feature/supervisor/data/models/supervisor_stats_model.dart';

abstract class SupervisorRemoteDataSource {
  Future<SupervisorInfoModel> getMyInfo();
  Future<SupervisorPatientModel> getPatient();
  Future<SupervisorReadingsResponseModel> getPatientReadings({
    required int limit,
  });
  Future<SupervisorAlertsResponseModel> getPatientAlerts({required int limit});
  Future<SupervisorLatestReadingsModel> getPatientLatestReadings();
  Future<SupervisorStatsModel> getPatientStats();
}

class SupervisorRemoteDataSourceImpl implements SupervisorRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'http://murafik.runasp.net/api/supervisor';

  SupervisorRemoteDataSourceImpl(this.dio);

  @override
  Future<SupervisorInfoModel> getMyInfo() async {
    final response = await dio.get(
      '$baseUrl/my-info',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return SupervisorInfoModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(
      message.isEmpty ? 'Failed to load supervisor info' : message,
    );
  }

  @override
  Future<SupervisorPatientModel> getPatient() async {
    final response = await dio.get(
      '$baseUrl/patient',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return SupervisorPatientModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load patient' : message);
  }

  @override
  Future<SupervisorReadingsResponseModel> getPatientReadings({
    required int limit,
  }) async {
    final response = await dio.get(
      '$baseUrl/patient-readings',
      queryParameters: {'limit': limit},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return SupervisorReadingsResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(
      message.isEmpty ? 'Failed to load patient readings' : message,
    );
  }

  @override
  Future<SupervisorAlertsResponseModel> getPatientAlerts({
    required int limit,
  }) async {
    final response = await dio.get(
      '$baseUrl/patient-alerts',
      queryParameters: {'limit': limit},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return SupervisorAlertsResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(
      message.isEmpty ? 'Failed to load patient alerts' : message,
    );
  }

  @override
  Future<SupervisorLatestReadingsModel> getPatientLatestReadings() async {
    final response = await dio.get(
      '$baseUrl/patient-latest-readings',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return SupervisorLatestReadingsModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(
      message.isEmpty ? 'Failed to load patient latest readings' : message,
    );
  }

  @override
  Future<SupervisorStatsModel> getPatientStats() async {
    final response = await dio.get(
      '$baseUrl/patient-stats',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return SupervisorStatsModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load patient stats' : message);
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
