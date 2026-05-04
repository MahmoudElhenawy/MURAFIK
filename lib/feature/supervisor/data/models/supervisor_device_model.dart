import 'package:murafik/feature/supervisor/domain/entities/supervisor_device_entity.dart';

class SupervisorDeviceModel extends SupervisorDeviceEntity {
  SupervisorDeviceModel({required int id, required String deviceSerial})
    : super(id: id, deviceSerial: deviceSerial);

  factory SupervisorDeviceModel.fromJson(Map<String, dynamic> json) {
    return SupervisorDeviceModel(
      id: json['id'] ?? 0,
      deviceSerial: json['deviceSerial'] ?? '',
    );
  }
}
