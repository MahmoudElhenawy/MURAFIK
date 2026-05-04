import 'package:flutter/material.dart';

class DeviceStatusChip extends StatelessWidget {
  final String label;
  final bool isConnected;

  const DeviceStatusChip({
    super.key,
    required this.label,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    final dotColor = isConnected
        ? const Color(0xFF4ADE80)
        : const Color(0xFFE24B4A);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
