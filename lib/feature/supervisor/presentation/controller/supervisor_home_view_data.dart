import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';

class SupervisorHomeViewData {
  final String supervisorName;
  final String supervisorRole;
  final SupervisorPatientViewData? patient;
  final List<SensorReadingViewData> sensors;
  final List<PatientAlertViewData> alerts;

  const SupervisorHomeViewData({
    required this.supervisorName,
    required this.supervisorRole,
    required this.patient,
    required this.sensors,
    required this.alerts,
  });

  static const empty = SupervisorHomeViewData(
    supervisorName: '',
    supervisorRole: '',
    patient: null,
    sensors: [],
    alerts: [],
  );
}

class SupervisorPatientViewData {
  final String name;
  final String age;
  final String gender;
  final String phone;
  final String address;
  final String status;
  final String doctorName;

  const SupervisorPatientViewData({
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.address,
    required this.status,
    required this.doctorName,
  });
}
