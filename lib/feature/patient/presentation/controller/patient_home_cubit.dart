import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/feature/patient/data/models/patient_reading_model.dart';
import 'package:murafik/feature/patient/domain/entities/alerts_response_entity.dart';
import 'package:murafik/feature/patient/domain/entities/doctor_entity.dart';
import 'package:murafik/feature/patient/domain/entities/patient_info_entity.dart';
import 'package:murafik/feature/patient/domain/entities/patient_reading_entity.dart';
import 'package:murafik/feature/patient/domain/usecases/get_alerts_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_device_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_doctor_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_latest_readings_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_my_info_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_readings_usecase.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';

enum PatientHomeStatus { initial, loading, loaded, failure }

class PatientHomeState {
  final PatientHomeStatus status;
  final PatientHomeViewData data;
  final String? message;

  const PatientHomeState({
    required this.status,
    required this.data,
    this.message,
  });

  PatientHomeState copyWith({
    PatientHomeStatus? status,
    PatientHomeViewData? data,
    String? message,
  }) {
    return PatientHomeState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message,
    );
  }
}

class PatientHomeCubit extends Cubit<PatientHomeState> {
  final GetMyInfoUsecase getMyInfoUsecase;
  final GetDoctorUsecase getDoctorUsecase;
  final GetReadingsUsecase getReadingsUsecase;
  final GetLatestReadingsUsecase getLatestReadingsUsecase;
  final GetAlertsUsecase getAlertsUsecase;
  final GetDeviceUsecase getDeviceUsecase;

  PatientHomeCubit({
    required this.getMyInfoUsecase,
    required this.getDoctorUsecase,
    required this.getReadingsUsecase,
    required this.getLatestReadingsUsecase,
    required this.getAlertsUsecase,
    required this.getDeviceUsecase,
  }) : super(
         const PatientHomeState(
           status: PatientHomeStatus.initial,
           data: PatientHomeViewData.empty,
         ),
       );

  Future<void> load({int limit = 20}) async {
    emit(state.copyWith(status: PatientHomeStatus.loading, message: null));

    final myInfoResult = await getMyInfoUsecase();
    final myInfo = myInfoResult.fold((failure) => null, (data) => data);
    if (myInfo == null) {
      emit(
        state.copyWith(
          status: PatientHomeStatus.failure,
          message: myInfoResult.fold((failure) => failure.message, (_) => ''),
        ),
      );
      return;
    }

    final doctorResult = await getDoctorUsecase();
    final doctor = doctorResult.fold((_) => null, (data) => data);

    final latestResult = await getLatestReadingsUsecase();
    final latestRaw = latestResult.fold((_) => null, (data) => data.raw);
    final latestMessage = latestResult.fold(
      (_) => null,
      (data) => data.message,
    );

    final deviceResult = await getDeviceUsecase();
    final deviceRaw = deviceResult.fold((_) => null, (data) => data.raw);
    final deviceMessage = deviceResult.fold(
      (_) => null,
      (data) => data.message,
    );

    final readingsResult = await getReadingsUsecase(limit: limit);
    final readings = readingsResult.fold(
      (_) => <PatientReadingEntity>[],
      (data) => data.readings,
    );

    final alertsResult = await getAlertsUsecase(limit: limit);
    final alerts = alertsResult.fold((_) => <PatientAlertViewData>[], (data) {
      return _mapAlerts(data);
    });

    final hasDevice =
        !_isNoDeviceMessage(latestMessage) &&
        !_isNoDeviceMessage(deviceMessage) &&
        (_hasReadings(latestRaw) || _hasDevice(deviceRaw));

    final latestReadings = _extractLatestReadings(latestRaw);

    final viewData = PatientHomeViewData(
      patientName: myInfo.name,
      greeting: _greetingForHour(DateTime.now().hour),
      doctor: _mapDoctor(myInfo, doctor),
      sensors: hasDevice
          ? _mapReadings(latestReadings.isNotEmpty ? latestReadings : readings)
          : <SensorReadingViewData>[],
      alerts: alerts,
      deviceStatus: hasDevice
          ? DeviceStatusViewData(
              label: _deviceLabel(deviceRaw, latestRaw),
              isConnected: true,
            )
          : null,
    );

    emit(state.copyWith(status: PatientHomeStatus.loaded, data: viewData));
  }

  static DoctorInfo? _mapDoctor(
    PatientInfoEntity myInfo,
    DoctorEntity? doctor,
  ) {
    if (myInfo.doctor != null) {
      final info = myInfo.doctor!;
      return DoctorInfo(
        name: info.name,
        specialty: info.specialization.isEmpty ? 'N/A' : info.specialization,
        phone: info.phone,
      );
    }
    if (doctor != null) {
      return DoctorInfo(
        name: doctor.name,
        specialty: doctor.specialization.isEmpty
            ? 'N/A'
            : doctor.specialization,
        phone: doctor.phone,
      );
    }
    return null;
  }

  static List<SensorReadingViewData> _mapReadings(
    List<PatientReadingEntity> readings,
  ) {
    return readings.map((reading) {
      final name = reading.name;
      final config = _sensorConfig(name);
      final status = _mapReadingStatus(reading.raw);
      return SensorReadingViewData(
        name: name,
        fullName: config.fullName,
        description: config.description,
        value: reading.value.isEmpty ? '--' : reading.value,
        unit: reading.unit,
        icon: config.icon,
        iconBg: config.iconBg,
        iconColor: config.iconColor,
        status: status,
      );
    }).toList();
  }

  static List<PatientAlertViewData> _mapAlerts(AlertsResponseEntity data) {
    return data.alerts.map((alert) {
      return PatientAlertViewData(
        title: alert.title,
        description: alert.description,
        time: _formatTime(alert.createdAt),
        severity: _mapSeverity(alert.severity),
      );
    }).toList();
  }

  static List<PatientReadingEntity> _extractLatestReadings(
    Map<String, dynamic>? raw,
  ) {
    if (raw == null) return <PatientReadingEntity>[];
    final readingsJson = raw['readings'];
    if (readingsJson is! List) return <PatientReadingEntity>[];
    return readingsJson
        .whereType<Map<String, dynamic>>()
        .map(PatientReadingModel.fromJson)
        .toList();
  }

  static bool _hasReadings(Map<String, dynamic>? raw) {
    if (raw == null) return false;
    final readingsJson = raw['readings'];
    return readingsJson is List && readingsJson.isNotEmpty;
  }

  static bool _hasDevice(Map<String, dynamic>? raw) {
    if (raw == null) return false;
    return raw['deviceSerial'] != null || raw['id'] != null;
  }

  static String _deviceLabel(
    Map<String, dynamic>? deviceRaw,
    Map<String, dynamic>? latestRaw,
  ) {
    final serial = latestRaw?['deviceSerial'] ?? deviceRaw?['deviceSerial'];
    if (serial != null) {
      return 'Device $serial connected';
    }
    return 'Device connected';
  }

  static SensorStatus _mapReadingStatus(Map<String, dynamic> raw) {
    final hasAlert = raw['hasAlert'];
    if (hasAlert is bool && hasAlert) {
      return SensorStatus.alert;
    }
    final alertType = raw['alertType'];
    if (alertType != null) {
      final value = alertType.toString().toLowerCase();
      if (value == 'high' || value == 'low') {
        return SensorStatus.alert;
      }
    }
    return SensorStatus.normal;
  }

  static bool _isNoDeviceMessage(String? message) {
    if (message == null) return false;
    return message.toLowerCase().contains('no device');
  }

  static String _greetingForHour(int hour) {
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  static String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--';
    final hh = dateTime.hour.toString().padLeft(2, '0');
    final mm = dateTime.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  static AlertSeverity _mapSeverity(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
      case 'high':
        return AlertSeverity.critical;
      case 'warning':
      case 'medium':
        return AlertSeverity.warning;
      default:
        return AlertSeverity.info;
    }
  }
}

class _SensorConfig {
  final String fullName;
  final String description;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const _SensorConfig({
    required this.fullName,
    required this.description,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });
}

_SensorConfig _sensorConfig(String name) {
  final key = name.toLowerCase();
  if (key.contains('ecg')) {
    return const _SensorConfig(
      fullName: 'ECG',
      description: 'Electrical activity of the heart',
      icon: Icons.monitor_heart_outlined,
      iconBg: Color(0xFFEFF6FF),
      iconColor: Color(0xFF2563EB),
    );
  }
  if (key.contains('emg')) {
    return const _SensorConfig(
      fullName: 'EMG',
      description: 'Electrical activity of muscles',
      icon: Icons.electric_bolt_outlined,
      iconBg: Color(0xFFF5F3FF),
      iconColor: Color(0xFF7C3AED),
    );
  }
  if (key.contains('temp')) {
    return const _SensorConfig(
      fullName: 'Temperature',
      description: 'Body temperature readings',
      icon: Icons.thermostat_outlined,
      iconBg: Color(0xFFFFF7ED),
      iconColor: Color(0xFFEA580C),
    );
  }
  if (key.contains('spo2') || key.contains('nir')) {
    return const _SensorConfig(
      fullName: 'SpO2',
      description: 'Oxygen saturation readings',
      icon: Icons.bloodtype_outlined,
      iconBg: Color(0xFFFEF2F2),
      iconColor: Color(0xFFDC2626),
    );
  }
  if (key.contains('gsr')) {
    return const _SensorConfig(
      fullName: 'GSR',
      description: 'Skin response readings',
      icon: Icons.monitor_heart_outlined,
      iconBg: Color(0xFFEFF6FF),
      iconColor: Color(0xFF1D4ED8),
    );
  }
  return const _SensorConfig(
    fullName: 'Reading',
    description: 'Sensor reading',
    icon: Icons.sensors_outlined,
    iconBg: Color(0xFFECFDF5),
    iconColor: Color(0xFF059669),
  );
}
