class DoctorInfoEntity {
  final int id;
  final String name;
  final String phone;
  final String specialization;
  final int patientsCount;
  final int activePatientsToday;

  DoctorInfoEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.specialization,
    required this.patientsCount,
    required this.activePatientsToday,
  });
}
