import 'package:flutter/material.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';

class AlertItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final AlertSeverity severity;

  const AlertItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    final config = switch (severity) {
      AlertSeverity.critical => (
        icon: Icons.warning_rounded,
        iconBg: const Color(0xFFFEE2E2),
        iconColor: const Color(0xFFDC2626),
      ),
      AlertSeverity.warning => (
        icon: Icons.info_rounded,
        iconBg: const Color(0xFFFEF9C3),
        iconColor: const Color(0xFFCA8A04),
      ),
      AlertSeverity.info => (
        icon: Icons.notifications_rounded,
        iconBg: const Color(0xFFEFF6FF),
        iconColor: const Color(0xFF2563EB),
      ),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: config.iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(config.icon, size: 17, color: config.iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
