import 'package:murafik/feature/supervisor/domain/entities/supervisor_stats_entity.dart';

class SupervisorStatsModel extends SupervisorStatsEntity {
  SupervisorStatsModel({
    required int totalReadings,
    required int readingsToday,
    required int readingsThisWeek,
    required int totalAlerts,
    required int alertsToday,
    required int alertsThisWeek,
    required int highAlerts,
    required int lowAlerts,
    required DateTime? lastReadingTime,
    required String status,
  }) : super(
         totalReadings: totalReadings,
         readingsToday: readingsToday,
         readingsThisWeek: readingsThisWeek,
         totalAlerts: totalAlerts,
         alertsToday: alertsToday,
         alertsThisWeek: alertsThisWeek,
         highAlerts: highAlerts,
         lowAlerts: lowAlerts,
         lastReadingTime: lastReadingTime,
         status: status,
       );

  factory SupervisorStatsModel.fromJson(Map<String, dynamic> json) {
    return SupervisorStatsModel(
      totalReadings: json['totalReadings'] ?? 0,
      readingsToday: json['readingsToday'] ?? 0,
      readingsThisWeek: json['readingsThisWeek'] ?? 0,
      totalAlerts: json['totalAlerts'] ?? 0,
      alertsToday: json['alertsToday'] ?? 0,
      alertsThisWeek: json['alertsThisWeek'] ?? 0,
      highAlerts: json['highAlerts'] ?? 0,
      lowAlerts: json['lowAlerts'] ?? 0,
      lastReadingTime: json['lastReadingTime'] != null
          ? DateTime.tryParse(json['lastReadingTime'].toString())
          : null,
      status: json['status'] ?? 'N/A',
    );
  }
}
