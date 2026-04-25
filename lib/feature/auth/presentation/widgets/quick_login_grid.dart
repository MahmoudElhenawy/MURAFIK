import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quick_login_card.dart';

class QuickLoginGrid extends StatelessWidget {
  const QuickLoginGrid({super.key});

  static const _roles = [
    {
      'role': 'Doctor',
      'image': 'assets/images/doctor.png',
      'icon': Icons.medical_services_outlined,
    },
    {
      'role': 'Patient',
      'image': 'assets/images/patient.jfif',
      'icon': Icons.person_outline,
    },
    {
      'role': 'Supervisor',
      'image': 'assets/images/supervesor.jfif',
      'icon': Icons.supervisor_account_outlined,
    },
    {
      'role': 'Admin',
      'image': 'assets/images/admin.jfif',
      'icon': Icons.admin_panel_settings_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.0,
        ),
        itemCount: _roles.length,
        itemBuilder: (context, index) {
          final item = _roles[index];
          return QuickLoginCard(
            item['role'] as String,
            imageUrl: item['image'] as String,
            icon: item['icon'] as IconData,
            onTap: () {
              context.push('/register', extra: item['role'] as String);
            },
          );
        },
      ),
    );
  }
}
