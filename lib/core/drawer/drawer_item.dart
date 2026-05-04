import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
    this.isActive = false,
    this.isDanger = false,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isActive;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final color = isDanger
        ? const Color(0xFFE24B4A)
        : isActive
        ? const Color(0xFF0A7CF8)
        : const Color(0xFF475569);

    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: isActive ? const Color(0xFF0A7CF8).withOpacity(0.08) : null,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDanger
              ? const Color(0xFFE24B4A).withOpacity(0.1)
              : isActive
              ? const Color(0xFF0A7CF8).withOpacity(0.12)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          color: color,
        ),
      ),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    );
  }
}
