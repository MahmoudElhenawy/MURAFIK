class SupervisorStatsEntity {
  final int totalReadings;
  final int readingsToday;
  final int readingsThisWeek;
  final int totalAlerts;
  final int alertsToday;
  final int alertsThisWeek;
  final int highAlerts;
  final int lowAlerts;
  final DateTime? lastReadingTime;
  final String status;

  SupervisorStatsEntity({
    required this.totalReadings,
    required this.readingsToday,
    required this.readingsThisWeek,
    required this.totalAlerts,
    required this.alertsToday,
    required this.alertsThisWeek,
    required this.highAlerts,
    required this.lowAlerts,
    required this.lastReadingTime,
    required this.status,
  });
}
