import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_patient_entity.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_patients_usecase.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_patients_view_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _patientsCacheKey = 'doctor_patients_cache';
const _patientsCacheAtKey = 'doctor_patients_cache_at';
const _cacheTtlMinutes = 10;

enum DoctorPatientsStatus { initial, loading, loaded, failure }

class DoctorPatientsState {
  final DoctorPatientsStatus status;
  final DoctorPatientsViewData data;
  final String? message;

  const DoctorPatientsState({
    required this.status,
    required this.data,
    this.message,
  });

  DoctorPatientsState copyWith({
    DoctorPatientsStatus? status,
    DoctorPatientsViewData? data,
    String? message,
  }) {
    return DoctorPatientsState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message,
    );
  }
}

class DoctorPatientsCubit extends Cubit<DoctorPatientsState> {
  final GetDoctorPatientsUsecase getDoctorPatientsUsecase;

  DoctorPatientsCubit({required this.getDoctorPatientsUsecase})
    : super(
        const DoctorPatientsState(
          status: DoctorPatientsStatus.initial,
          data: DoctorPatientsViewData.empty,
        ),
      );

  Future<void> load() async {
    if (isClosed) return;

    final cached = await _readCache();
    if (cached != null) {
      emit(
        state.copyWith(
          status: DoctorPatientsStatus.loaded,
          data: DoctorPatientsViewData(patients: cached.patients),
        ),
      );

      if (_isCacheFresh(cached.cachedAt)) {
        return;
      }
    }

    emit(state.copyWith(status: DoctorPatientsStatus.loading, message: null));

    final result = await getDoctorPatientsUsecase();
    final data = result.fold((_) => null, (response) => response);

    if (isClosed) return;
    if (data == null) {
      emit(
        state.copyWith(
          status: DoctorPatientsStatus.failure,
          message: result.fold((f) => f.message, (_) => ''),
        ),
      );
      return;
    }

    final patients = data.patients.map(_mapPatient).toList();

    await _writeCache(patients);

    if (isClosed) return;
    emit(
      state.copyWith(
        status: DoctorPatientsStatus.loaded,
        data: DoctorPatientsViewData(patients: patients),
      ),
    );
  }

  static bool _isCacheFresh(int cachedAtMs) {
    final cachedAt = DateTime.fromMillisecondsSinceEpoch(cachedAtMs);
    final age = DateTime.now().difference(cachedAt).inMinutes;
    return age < _cacheTtlMinutes;
  }

  static Future<_PatientsCacheEntry?> _readCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_patientsCacheKey);
    final cachedAt = prefs.getInt(_patientsCacheAtKey);
    if (raw == null || cachedAt == null) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return null;
      final patients = decoded
          .whereType<Map<String, dynamic>>()
          .map(_mapCachedPatient)
          .toList();
      return _PatientsCacheEntry(patients: patients, cachedAt: cachedAt);
    } catch (_) {
      return null;
    }
  }

  static Future<void> _writeCache(
    List<DoctorPatientCardViewData> patients,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(patients.map(_encodePatient).toList());
    await prefs.setString(_patientsCacheKey, encoded);
    await prefs.setInt(
      _patientsCacheAtKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  static DoctorPatientCardViewData _mapPatient(DoctorPatientEntity patient) {
    final latest = patient.latestReading;
    final sensorName = latest?['sensorName']?.toString();
    final value = latest?['value']?.toString();
    final condition = sensorName != null && value != null
        ? '$sensorName: $value'
        : '';

    return DoctorPatientCardViewData(
      id: patient.id,
      name: patient.name,
      condition: condition,
      age: patient.age > 0 ? patient.age.toString() : '',
      status: patient.status,
      gender: patient.gender,
      doctorName: '',
      phone: patient.phone,
      address: patient.address,
      deviceSerial: patient.deviceSerial,
    );
  }

  static DoctorPatientCardViewData _mapCachedPatient(
    Map<String, dynamic> json,
  ) {
    return DoctorPatientCardViewData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      condition: json['condition'] ?? '',
      age: json['age']?.toString(),
      status: json['status'] ?? '',
      gender: json['gender'] ?? '',
      doctorName: json['doctorName'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      deviceSerial: json['deviceSerial']?.toString(),
    );
  }

  static Map<String, dynamic> _encodePatient(
    DoctorPatientCardViewData patient,
  ) {
    return {
      'id': patient.id,
      'name': patient.name,
      'condition': patient.condition,
      'age': patient.age,
      'status': patient.status,
      'gender': patient.gender,
      'doctorName': patient.doctorName,
      'phone': patient.phone,
      'address': patient.address,
      'deviceSerial': patient.deviceSerial,
    };
  }
}

class _PatientsCacheEntry {
  final List<DoctorPatientCardViewData> patients;
  final int cachedAt;

  const _PatientsCacheEntry({required this.patients, required this.cachedAt});
}
