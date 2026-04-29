import 'package:flutter/material.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';

class PatientReadingsScreen extends StatelessWidget {
  final PatientHomeViewData? data;

  const PatientReadingsScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final viewData = data ?? PatientHomeViewData.preview;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Readings'),
        backgroundColor: Colors.blue,
        foregroundColor: const Color(0xFFffffff),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: viewData.sensors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final sensor = viewData.sensors[index];
              return _ReadingTile(sensor: sensor);
            },
          ),
        ],
      ),
    );
  }
}

class _ReadingTile extends StatelessWidget {
  final SensorReadingViewData sensor;

  const _ReadingTile({required this.sensor});

  String get _statusLabel => switch (sensor.status) {
    SensorStatus.normal => 'طبيعي',
    SensorStatus.elevated || SensorStatus.alert => 'غير طبيعي',
  };

  Color get _statusColor => switch (sensor.status) {
    SensorStatus.normal => const Color(0xFF1D9E75),
    SensorStatus.elevated => const Color(0xFFEF9F27),
    SensorStatus.alert => const Color(0xFFE24B4A),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: switch (sensor.status) {
            SensorStatus.normal => Colors.black.withOpacity(0.05),
            SensorStatus.elevated => const Color(0xFFBA7517).withOpacity(0.2),
            SensorStatus.alert => const Color(0xFFA32D2D).withOpacity(0.2),
          },
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: sensor.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(sensor.icon, color: sensor.iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sensor.fullName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sensor.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${sensor.value} ${sensor.unit}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _statusLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
