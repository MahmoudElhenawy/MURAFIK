import 'package:dio/dio.dart';
import 'package:murafik/feature/patient/data/models/alerts_response_model.dart';
import 'package:murafik/feature/patient/data/models/doctor_model.dart';
import 'package:murafik/feature/patient/data/models/message_response_model.dart';
import 'package:murafik/feature/patient/data/models/patient_info_model.dart';
import 'package:murafik/feature/patient/data/models/readings_response_model.dart';

abstract class PatientRemoteDataSource {
  Future<PatientInfoModel> getMyInfo();

  Future<DoctorModel> getDoctor();

  Future<ReadingsResponseModel> getReadings({required int limit});

  Future<MessageResponseModel> getLatestReadings();

  Future<AlertsResponseModel> getAlerts({required int limit});

  Future<MessageResponseModel> getDevice();
}

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://murafik.runasp.net/api/patient';

  PatientRemoteDataSourceImpl(this.dio);

  @override
  Future<PatientInfoModel> getMyInfo() async {
    final response = await dio.get(
      '$baseUrl/my-info',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return PatientInfoModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load patient info' : message);
  }

  @override
  Future<DoctorModel> getDoctor() async {
    final response = await dio.get(
      '$baseUrl/doctor',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return DoctorModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load doctor' : message);
  }

  @override
  Future<ReadingsResponseModel> getReadings({required int limit}) async {
    final response = await dio.get(
      '$baseUrl/readings',
      queryParameters: {'limit': limit},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return ReadingsResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load readings' : message);
  }

  @override
  Future<MessageResponseModel> getLatestReadings() async {
    final response = await dio.get(
      '$baseUrl/latest-readings',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return MessageResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(
      message.isEmpty ? 'Failed to load latest readings' : message,
    );
  }

  @override
  Future<AlertsResponseModel> getAlerts({required int limit}) async {
    final response = await dio.get(
      '$baseUrl/alerts',
      queryParameters: {'limit': limit},
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return AlertsResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load alerts' : message);
  }

  @override
  Future<MessageResponseModel> getDevice() async {
    final response = await dio.get(
      '$baseUrl/device',
      options: Options(validateStatus: (status) => status != null),
    );

    if (response.statusCode == 200) {
      return MessageResponseModel.fromJson(response.data);
    }

    final message = _extractErrorMessage(response.data);
    throw Exception(message.isEmpty ? 'Failed to load device' : message);
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
