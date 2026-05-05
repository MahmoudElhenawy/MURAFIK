class DoctorPatientsViewData {
  final List<DoctorPatientCardViewData> patients;

  const DoctorPatientsViewData({required this.patients});

  static const empty = DoctorPatientsViewData(patients: []);
}

class DoctorPatientCardViewData {
  final int id;
  final String name;
  final String condition;
  final String? age;
  final String status;
  final String gender;
  final String doctorName;
  final String phone;
  final String address;
  final String? deviceSerial;

  const DoctorPatientCardViewData({
    required this.id,
    required this.name,
    required this.condition,
    required this.age,
    required this.status,
    required this.gender,
    required this.doctorName,
    required this.phone,
    required this.address,
    required this.deviceSerial,
  });
}
