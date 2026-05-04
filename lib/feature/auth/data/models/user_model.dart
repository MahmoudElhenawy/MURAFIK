import 'package:murafik/feature/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required int id,
    required String username,
    required String email,
    required String role,
    int? patientId,
    int? doctorId,
    int? supervisorId,
  }) : super(
         id: id,
         username: username,
         email: email,
         role: role,
         patientId: patientId,
         doctorId: doctorId,
         supervisorId: supervisorId,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      supervisorId: json['supervisorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'patientId': patientId,
      'doctorId': doctorId,
      'supervisorId': supervisorId,
    };
  }
}
