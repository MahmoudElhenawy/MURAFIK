import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_alerts_response_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_patient_entity.dart';
import 'package:murafik/feature/supervisor/domain/entities/supervisor_reading_entity.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_my_info_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_alerts_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_latest_readings_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_readings_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_stats_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_usecase.dart';
import 'package:murafik/feature/supervisor/presentation/controller/supervisor_home_view_data.dart';

enum SupervisorHomeStatus { initial, loading, loaded, failure }

class SupervisorHomeState {
  final SupervisorHomeStatus status;
  final SupervisorHomeViewData data;
  final String? message;

  const SupervisorHomeState({
    required this.status,
    required this.data,
    this.message,
  });

  SupervisorHomeState copyWith({
    SupervisorHomeStatus? status,
    SupervisorHomeViewData? data,
    String? message,
  }) {
    return SupervisorHomeState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message,
    );
  }
}

class SupervisorHomeCubit extends Cubit<SupervisorHomeState> {
  final GetSupervisorMyInfoUsecase getMyInfoUsecase;
  final GetSupervisorPatientUsecase getPatientUsecase;
  final GetSupervisorPatientReadingsUsecase getPatientReadingsUsecase;
  final GetSupervisorPatientLatestReadingsUsecase
  getPatientLatestReadingsUsecase;
  final GetSupervisorPatientAlertsUsecase getPatientAlertsUsecase;
  final GetSupervisorPatientStatsUsecase getPatientStatsUsecase;

  SupervisorHomeCubit({
    required this.getMyInfoUsecase,
    required this.getPatientUsecase,
    required this.getPatientReadingsUsecase,
    required this.getPatientLatestReadingsUsecase,
    required this.getPatientAlertsUsecase,
    required this.getPatientStatsUsecase,
  }) : super(
         const SupervisorHomeState(
           status: SupervisorHomeStatus.initial,
           data: SupervisorHomeViewData.empty,
         ),
       );

  Future<void> load({int limit = 20}) async {
    emit(state.copyWith(status: SupervisorHomeStatus.loading, message: null));

    final myInfoResult = await getMyInfoUsecase();
    final myInfo = myInfoResult.fold((_) => null, (data) => data);
    if (myInfo == null) {
      emit(
        state.copyWith(
          status: SupervisorHomeStatus.failure,
          message: myInfoResult.fold((f) => f.message, (_) => ''),
        ),
      );
      return;
    }

    final patientResult = await getPatientUsecase();
    final patient = patientResult.fold((_) => null, (data) => data);

    final latestResult = await getPatientLatestReadingsUsecase();
    final latestReadings = latestResult.fold(
      (_) => <SupervisorReadingEntity>[],
      (data) => data.readings,
    );

    final readingsResult = await getPatientReadingsUsecase(limit: limit);
    final readings = readingsResult.fold(
      (_) => <SupervisorReadingEntity>[],
      (data) => data.readings,
    );

    final alertsResult = await getPatientAlertsUsecase(limit: limit);
    final alerts = alertsResult.fold((_) => <PatientAlertViewData>[], (data) {
      return _mapAlerts(data);
    });

    await getPatientStatsUsecase();

    final viewData = SupervisorHomeViewData(
      supervisorName: myInfo.name,
      supervisorRole: myInfo.role,
      patient: patient != null ? _mapPatient(patient) : null,
      sensors: _mapReadings(
        latestReadings.isNotEmpty ? latestReadings : readings,
      ),
      alerts: alerts,
    );

    emit(state.copyWith(status: SupervisorHomeStatus.loaded, data: viewData));
  }

  static SupervisorPatientViewData _mapPatient(
    SupervisorPatientEntity patient,
  ) {
    return SupervisorPatientViewData(
      name: patient.name,
      age: patient.age.toString(),
      gender: patient.gender,
      phone: patient.phone,
      address: patient.address,
      status: patient.status,
      doctorName: patient.doctor?.name ?? 'N/A',
    );
  }

  static List<SensorReadingViewData> _mapReadings(
    List<SupervisorReadingEntity> readings,
  ) {
    return readings.map((reading) {
      final config = _sensorConfig(reading.sensorName);
      return SensorReadingViewData(
        name: reading.sensorName,
        fullName: config.fullName,
        description: config.description,
        value: reading.value.isEmpty ? '--' : reading.value,
        unit: reading.unit,
        icon: config.icon,
        iconBg: config.iconBg,
        iconColor: config.iconColor,
        status: _mapReadingStatus(reading),
      );
    }).toList();
  }

  static List<PatientAlertViewData> _mapAlerts(
    SupervisorAlertsResponseEntity data,
  ) {
    return data.alerts.map((alert) {
      return PatientAlertViewData(
        title: alert.sensorName,
        description: '${alert.sensorName} alert at ${alert.currentValue}',
        time: _formatTime(alert.createdAt),
        severity: _mapSeverity(alert.alertType),
      );
    }).toList();
  }

  static SensorStatus _mapReadingStatus(SupervisorReadingEntity reading) {
    if (reading.hasAlert) {
      return SensorStatus.alert;
    }
    final type = reading.alertType?.toLowerCase();
    if (type == 'high' || type == 'low') {
      return SensorStatus.alert;
    }
    return SensorStatus.normal;
  }

  static AlertSeverity _mapSeverity(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
      case 'critical':
        return AlertSeverity.critical;
      case 'low':
      case 'warning':
        return AlertSeverity.warning;
      default:
        return AlertSeverity.info;
    }
  }

  static String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--';
    final hh = dateTime.hour.toString().padLeft(2, '0');
    final mm = dateTime.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
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
  if (key.contains('heart')) {
    return const _SensorConfig(
      fullName: 'Heart Rate',
      description: 'Heart rate readings',
      icon: Icons.monitor_heart_outlined,
      iconBg: Color(0xFFEFF6FF),
      iconColor: Color(0xFF2563EB),
    );
  }
  if (key.contains('temp')) {
    return const _SensorConfig(
      fullName: 'Body Temperature',
      description: 'Body temperature readings',
      icon: Icons.thermostat_outlined,
      iconBg: Color(0xFFFFF7ED),
      iconColor: Color(0xFFEA580C),
    );
  }
  if (key.contains('oxygen')) {
    return const _SensorConfig(
      fullName: 'Blood Oxygen',
      description: 'Oxygen saturation readings',
      icon: Icons.bloodtype_outlined,
      iconBg: Color(0xFFFEF2F2),
      iconColor: Color(0xFFDC2626),
    );
  }
  if (key.contains('pressure')) {
    return const _SensorConfig(
      fullName: 'Blood Pressure',
      description: 'Blood pressure readings',
      icon: Icons.favorite_outline,
      iconBg: Color(0xFFF5F3FF),
      iconColor: Color(0xFF7C3AED),
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
