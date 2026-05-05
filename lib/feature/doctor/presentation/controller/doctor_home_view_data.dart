class DoctorHomeViewData {
  final String doctorName;
  final String specialization;
  final String phone;
  final int patientsCount;
  final int activePatientsToday;
  final int totalAlerts;
  final int highPriorityPatients;
  final List<DoctorCriticalPatientViewData> criticalPatients;
  final List<DoctorAlertViewData> alerts;

  const DoctorHomeViewData({
    required this.doctorName,
    required this.specialization,
    required this.phone,
    required this.patientsCount,
    required this.activePatientsToday,
    required this.totalAlerts,
    required this.highPriorityPatients,
    required this.criticalPatients,
    required this.alerts,
  });

  static const empty = DoctorHomeViewData(
    doctorName: '',
    specialization: '',
    phone: '',
    patientsCount: 0,
    activePatientsToday: 0,
    totalAlerts: 0,
    highPriorityPatients: 0,
    criticalPatients: [],
    alerts: [],
  );
}

class DoctorCriticalPatientViewData {
  final int patientId;
  final String name;
  final String condition;
  final String age;
  final String gender;
  final String phone;
  final String alertType;
  final String currentValue;

  const DoctorCriticalPatientViewData({
    required this.patientId,
    required this.name,
    required this.condition,
    required this.age,
    required this.gender,
    required this.phone,
    required this.alertType,
    required this.currentValue,
  });
}

class DoctorAlertViewData {
  final String title;
  final String patientName;
  final String time;
  final bool isCritical;

  const DoctorAlertViewData({
    required this.title,
    required this.patientName,
    required this.time,
    required this.isCritical,
  });
}
