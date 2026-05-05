class DoctorPatientEntity {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String address;
  final String? deviceSerial;
  final int supervisorCount;
  final Map<String, dynamic>? latestReading;
  final int alertCountToday;
  final int totalAlerts;
  final String status;

  DoctorPatientEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.address,
    required this.deviceSerial,
    required this.supervisorCount,
    required this.latestReading,
    required this.alertCountToday,
    required this.totalAlerts,
    required this.status,
  });
}
