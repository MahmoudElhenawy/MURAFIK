class UserEntity {
  final int id;
  final String username;
  final String email;
  final String role;
  final int? patientId;
  final int? doctorId;
  final int? supervisorId;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.patientId,
    this.doctorId,
    this.supervisorId,
  });
}
