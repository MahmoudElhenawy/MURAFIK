import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_all_alerts_usecase.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_home_view_data.dart';

enum DoctorAlertsStatus { initial, loading, loaded, failure }

class DoctorAlertsState {
  final DoctorAlertsStatus status;
  final List<DoctorAlertViewData> alerts;
  final String? message;

  const DoctorAlertsState({
    required this.status,
    required this.alerts,
    this.message,
  });

  DoctorAlertsState copyWith({
    DoctorAlertsStatus? status,
    List<DoctorAlertViewData>? alerts,
    String? message,
  }) {
    return DoctorAlertsState(
      status: status ?? this.status,
      alerts: alerts ?? this.alerts,
      message: message,
    );
  }
}

class DoctorAlertsCubit extends Cubit<DoctorAlertsState> {
  final GetDoctorAllAlertsUsecase getDoctorAllAlertsUsecase;

  DoctorAlertsCubit({required this.getDoctorAllAlertsUsecase})
    : super(
        const DoctorAlertsState(status: DoctorAlertsStatus.initial, alerts: []),
      );

  Future<void> load({int hours = 100}) async {
    emit(state.copyWith(status: DoctorAlertsStatus.loading, message: null));

    final result = await getDoctorAllAlertsUsecase(hours: hours);
    final data = result.fold((_) => null, (response) => response);

    if (data == null) {
      emit(
        state.copyWith(
          status: DoctorAlertsStatus.failure,
          message: result.fold((f) => f.message, (_) => ''),
        ),
      );
      return;
    }

    final alerts = data.allAlerts.map((alert) {
      final isHigh =
          alert.alertType.toLowerCase() == 'high' ||
          alert.alertType.toLowerCase() == 'critical';
      final time = _formatTime(alert.createdAt);
      final title = isHigh
          ? 'High ${alert.sensorName}'
          : 'Low ${alert.sensorName}';
      return DoctorAlertViewData(
        title: title,
        patientName: alert.patientName ?? '',
        time: time,
        isCritical: isHigh,
      );
    }).toList();

    emit(state.copyWith(status: DoctorAlertsStatus.loaded, alerts: alerts));
  }

  static String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--';
    final hh = dateTime.hour.toString().padLeft(2, '0');
    final mm = dateTime.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }
}
