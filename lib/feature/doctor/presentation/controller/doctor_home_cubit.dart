import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_all_alerts_entity.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_priority_patients_response_entity.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_all_alerts_usecase.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_my_info_usecase.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_priority_patients_usecase.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_home_view_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _homeCacheKey = 'doctor_home_cache';
const _homeCacheAtKey = 'doctor_home_cache_at';
const _homeCacheTtlMinutes = 10;

enum DoctorHomeStatus { initial, loading, loaded, failure }

class DoctorHomeState {
  final DoctorHomeStatus status;
  final DoctorHomeViewData data;
  final String? message;

  const DoctorHomeState({
    required this.status,
    required this.data,
    this.message,
  });

  DoctorHomeState copyWith({
    DoctorHomeStatus? status,
    DoctorHomeViewData? data,
    String? message,
  }) {
    return DoctorHomeState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message,
    );
  }
}

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  final GetDoctorMyInfoUsecase getMyInfoUsecase;
  final GetDoctorAllAlertsUsecase getAllAlertsUsecase;
  final GetDoctorPriorityPatientsUsecase getPriorityPatientsUsecase;

  DoctorHomeCubit({
    required this.getMyInfoUsecase,
    required this.getAllAlertsUsecase,
    required this.getPriorityPatientsUsecase,
  }) : super(
         const DoctorHomeState(
           status: DoctorHomeStatus.initial,
           data: DoctorHomeViewData.empty,
         ),
       );

  Future<void> load({int hours = 100, int alertThreshold = 0}) async {
    final cached = await _readCache();
    if (cached != null) {
      emit(state.copyWith(status: DoctorHomeStatus.loaded, data: cached.data));

      if (_isCacheFresh(cached.cachedAt)) {
        return;
      }
    }

    emit(state.copyWith(status: DoctorHomeStatus.loading, message: null));

    final infoResult = await getMyInfoUsecase();
    final info = infoResult.fold((_) => null, (data) => data);
    if (info == null) {
      emit(
        state.copyWith(
          status: DoctorHomeStatus.failure,
          message: infoResult.fold((f) => f.message, (_) => ''),
        ),
      );
      return;
    }

    final alertsResult = await getAllAlertsUsecase(hours: hours);
    final alerts = alertsResult.fold((_) => null, (data) => data);

    final priorityResult = await getPriorityPatientsUsecase(
      alertThreshold: alertThreshold,
    );
    final priority = priorityResult.fold((_) => null, (data) => data);

    final viewData = DoctorHomeViewData(
      doctorName: info.name,
      specialization: info.specialization,
      phone: info.phone,
      patientsCount: info.patientsCount,
      activePatientsToday: info.activePatientsToday,
      totalAlerts: alerts?.totalAlerts ?? 0,
      highPriorityPatients: alerts?.highPriorityPatients ?? 0,
      criticalPatients: _mapCriticalPatients(priority),
      alerts: _mapAlerts(alerts),
    );

    await _writeCache(viewData);

    emit(state.copyWith(status: DoctorHomeStatus.loaded, data: viewData));
  }

  static bool _isCacheFresh(int cachedAtMs) {
    final cachedAt = DateTime.fromMillisecondsSinceEpoch(cachedAtMs);
    final age = DateTime.now().difference(cachedAt).inMinutes;
    return age < _homeCacheTtlMinutes;
  }

  static Future<_HomeCacheEntry?> _readCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_homeCacheKey);
    final cachedAt = prefs.getInt(_homeCacheAtKey);
    if (raw == null || cachedAt == null) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      final viewData = _decodeViewData(decoded);
      return _HomeCacheEntry(data: viewData, cachedAt: cachedAt);
    } catch (_) {
      return null;
    }
  }

  static Future<void> _writeCache(DoctorHomeViewData data) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_encodeViewData(data));
    await prefs.setString(_homeCacheKey, encoded);
    await prefs.setInt(_homeCacheAtKey, DateTime.now().millisecondsSinceEpoch);
  }

  static List<DoctorCriticalPatientViewData> _mapCriticalPatients(
    DoctorPriorityPatientsResponseEntity? data,
  ) {
    if (data == null) return [];
    return data.patients.map((patient) {
      final latest = patient.latestAlert;
      final condition = latest != null
          ? _formatAlertTitle(latest.sensorName, latest.alertType)
          : 'No alerts';
      return DoctorCriticalPatientViewData(
        patientId: patient.id,
        name: patient.name,
        condition: condition,
        age: patient.age > 0 ? patient.age.toString() : '',
        gender: patient.gender,
        phone: patient.phone,
        alertType: latest?.alertType ?? '',
        currentValue: latest?.currentValue ?? '',
      );
    }).toList();
  }

  static List<DoctorAlertViewData> _mapAlerts(DoctorAllAlertsEntity? data) {
    if (data == null) return [];
    return data.allAlerts.map((alert) {
      return DoctorAlertViewData(
        title: _formatAlertTitle(alert.sensorName, alert.alertType),
        patientName: alert.patientName ?? '',
        time: _formatTime(alert.createdAt),
        isCritical: _isHigh(alert.alertType),
      );
    }).toList();
  }

  static String _formatAlertTitle(String sensorName, String alertType) {
    final severity = _isHigh(alertType) ? 'High' : 'Low';
    return '$severity $sensorName';
  }

  static bool _isHigh(String alertType) {
    return alertType.toLowerCase() == 'high' ||
        alertType.toLowerCase() == 'critical';
  }

  static String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--';
    final hh = dateTime.hour.toString().padLeft(2, '0');
    final mm = dateTime.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  static Map<String, dynamic> _encodeViewData(DoctorHomeViewData data) {
    return {
      'doctorName': data.doctorName,
      'specialization': data.specialization,
      'phone': data.phone,
      'patientsCount': data.patientsCount,
      'activePatientsToday': data.activePatientsToday,
      'totalAlerts': data.totalAlerts,
      'highPriorityPatients': data.highPriorityPatients,
      'criticalPatients': data.criticalPatients
          .map(
            (patient) => {
              'patientId': patient.patientId,
              'name': patient.name,
              'condition': patient.condition,
              'age': patient.age,
              'gender': patient.gender,
              'phone': patient.phone,
              'alertType': patient.alertType,
              'currentValue': patient.currentValue,
            },
          )
          .toList(),
      'alerts': data.alerts
          .map(
            (alert) => {
              'title': alert.title,
              'patientName': alert.patientName,
              'time': alert.time,
              'isCritical': alert.isCritical,
            },
          )
          .toList(),
    };
  }

  static DoctorHomeViewData _decodeViewData(Map<String, dynamic> json) {
    final criticalJson = json['criticalPatients'];
    final criticalPatients = criticalJson is List
        ? criticalJson
              .whereType<Map<String, dynamic>>()
              .map(
                (patient) => DoctorCriticalPatientViewData(
                  patientId: patient['patientId'] ?? 0,
                  name: patient['name'] ?? '',
                  condition: patient['condition'] ?? '',
                  age: patient['age']?.toString() ?? '',
                  gender: patient['gender'] ?? '',
                  phone: patient['phone'] ?? '',
                  alertType: patient['alertType'] ?? '',
                  currentValue: patient['currentValue'] ?? '',
                ),
              )
              .toList()
        : <DoctorCriticalPatientViewData>[];

    final alertsJson = json['alerts'];
    final alerts = alertsJson is List
        ? alertsJson
              .whereType<Map<String, dynamic>>()
              .map(
                (alert) => DoctorAlertViewData(
                  title: alert['title'] ?? '',
                  patientName: alert['patientName'] ?? '',
                  time: alert['time'] ?? '',
                  isCritical: alert['isCritical'] == true,
                ),
              )
              .toList()
        : <DoctorAlertViewData>[];

    return DoctorHomeViewData(
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
      phone: json['phone'] ?? '',
      patientsCount: json['patientsCount'] ?? 0,
      activePatientsToday: json['activePatientsToday'] ?? 0,
      totalAlerts: json['totalAlerts'] ?? 0,
      highPriorityPatients: json['highPriorityPatients'] ?? 0,
      criticalPatients: criticalPatients,
      alerts: alerts,
    );
  }
}

class _HomeCacheEntry {
  final DoctorHomeViewData data;
  final int cachedAt;

  const _HomeCacheEntry({required this.data, required this.cachedAt});
}
