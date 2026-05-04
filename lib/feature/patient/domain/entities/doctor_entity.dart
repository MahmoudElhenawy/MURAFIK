class DoctorEntity {
  final int id;
  final String name;
  final String phone;
  final String specialization;
  final int? totalPatients;

  DoctorEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.specialization,
    this.totalPatients,
  });
}
