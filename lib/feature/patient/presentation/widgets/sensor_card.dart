import 'package:flutter/material.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';

class SensorCard extends StatelessWidget {
  final String name;
  final String value;
  final String unit;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final SensorStatus status;
  final VoidCallback? onTap;

  const SensorCard({
    super.key,
    required this.name,
    required this.value,
    required this.unit,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: switch (status) {
              SensorStatus.normal => Colors.black.withOpacity(0.07),
              SensorStatus.elevated => const Color(
                0xFFBA7517,
              ).withOpacity(0.25),
              SensorStatus.alert => const Color(0xFFA32D2D).withOpacity(0.2),
            },
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _IconWithDot(
              icon: icon,
              iconBg: iconBg,
              iconColor: iconColor,
              status: status,
            ),
            const SizedBox(height: 14),
            Text(
              name.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                    height: 1,
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _StatusBadge(status: status),
          ],
        ),
      ),
    );
  }
}

class _IconWithDot extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final SensorStatus status;

  const _IconWithDot({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.status,
  });

  Color get _dotColor => switch (status) {
    SensorStatus.normal => const Color(0xFF1D9E75),
    SensorStatus.elevated => const Color(0xFFEF9F27),
    SensorStatus.alert => const Color(0xFFE24B4A),
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 22, color: iconColor),
        ),
        Positioned(
          top: -3,
          right: -3,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _dotColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final SensorStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final config = switch (status) {
      SensorStatus.normal => (
        label: 'Normal',
        bg: const Color(0xFFEAF3DE),
        fg: const Color(0xFF3B6D11),
      ),
      SensorStatus.elevated => (
        label: 'Elevated',
        bg: const Color(0xFFFAEEDA),
        fg: const Color(0xFF854F0B),
      ),
      SensorStatus.alert => (
        label: 'Alert',
        bg: const Color(0xFFFCEBEB),
        fg: const Color(0xFFA32D2D),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        config.label,
        style: TextStyle(
          fontSize: 11,
          color: config.fg,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
