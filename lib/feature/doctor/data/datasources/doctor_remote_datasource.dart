import 'package:dio/dio.dart';
import 'package:murafik/feature/doctor/data/models/doctor_all_alerts_model.dart';
import 'package:murafik/feature/doctor/data/models/doctor_alerts_response_model.dart';
import 'package:murafik/feature/doctor/data/models/doctor_info_model.dart';
import 'package:murafik/feature/doctor/data/models/doctor_patients_response_model.dart';
import 'package:murafik/feature/doctor/data/models/doctor_priority_patients_response_model.dart';
import 'package:murafik/feature/doctor/data/models/doctor_readings_response_model.dart';

abstract class DoctorRemoteDataSource {
  Future<DoctorInfoModel> getMyInfo();
  Future<DoctorPatientsResponseModel> getPatients();
  Future<DoctorReadingsResponseModel> getPatientReadings({
    required int patientId,
    required int limit,
  });
  Future<DoctorAlertsResponseModel> getPatientAlerts({
    required int patientId,
    required int limit,
  });
  Future<DoctorAllAlertsModel> getAllAlerts({required int hours});
  Future<DoctorPriorityPatientsResponseModel> getPriorityPatients({
    required int alertThreshold,
  });
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://murafik.runasp.net/api/doctor';

  DoctorRemoteDataSourceImpl(this.dio);

  @override
  Future<DoctorInfoModel> getMyInfo() async {
    final response = await dio.get(
      '$baseUrl/my-info',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return DoctorInfoModel.fromJson(_unwrapData(response.data));
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load doctor info' : message);
  }

  @override
  Future<DoctorPatientsResponseModel> getPatients() async {
    final response = await dio.get(
      '$baseUrl/patients',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return DoctorPatientsResponseModel.fromJson(_unwrapData(response.data));
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load patients' : message);
  }

  @override
  Future<DoctorReadingsResponseModel> getPatientReadings({
    required int patientId,
    required int limit,
  }) async {
    final response = await dio.get(
      '$baseUrl/patients/$patientId/readings',
      queryParameters: {'limit': limit},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return DoctorReadingsResponseModel.fromJson(_unwrapData(response.data));
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load readings' : message);
  }

  @override
  Future<DoctorAlertsResponseModel> getPatientAlerts({
    required int patientId,
    required int limit,
  }) async {
    final response = await dio.get(
      '$baseUrl/patients/$patientId/alerts',
      queryParameters: {'limit': limit},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return DoctorAlertsResponseModel.fromJson(_unwrapData(response.data));
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load alerts' : message);
  }

  @override
  Future<DoctorAllAlertsModel> getAllAlerts({required int hours}) async {
    final response = await dio.get(
      '$baseUrl/all-alerts',
      queryParameters: {'hours': hours},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return DoctorAllAlertsModel.fromJson(_unwrapData(response.data));
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load alerts' : message);
  }

  @override
  Future<DoctorPriorityPatientsResponseModel> getPriorityPatients({
    required int alertThreshold,
  }) async {
    final response = await dio.get(
      '$baseUrl/priority-patients',
      queryParameters: {'alertThreshold': alertThreshold},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return DoctorPriorityPatientsResponseModel.fromJson(
        _unwrapData(response.data),
      );
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(
      message.isEmpty ? 'Failed to load priority patients' : message,
    );
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

  Map<String, dynamic> _unwrapData(dynamic data) {
    if (data is Map<String, dynamic>) {
      final inner = data['data'];
      if (inner is Map<String, dynamic>) {
        return inner;
      }
    }
    return data is Map<String, dynamic> ? data : <String, dynamic>{};
  }
}
