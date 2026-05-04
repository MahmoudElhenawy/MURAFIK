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
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Doctor & Supervisor
          Row(
            children: [
              Expanded(
                child: QuickLoginCard(
                  _roles[0]['role'] as String,
                  imageUrl: _roles[0]['image'] as String,
                  icon: _roles[0]['icon'] as IconData,
                  onTap: () => context.push(
                    '/register',
                    extra: _roles[0]['role'] as String,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: QuickLoginCard(
                  _roles[2]['role'] as String,
                  imageUrl: _roles[2]['image'] as String,
                  icon: _roles[2]['icon'] as IconData,
                  onTap: () => context.push(
                    '/register',
                    extra: _roles[2]['role'] as String,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Patient centered
          Center(
            child: SizedBox(
              width: (MediaQuery.of(context).size.width - 48 - 20) / 2,
              child: QuickLoginCard(
                _roles[1]['role'] as String,
                imageUrl: _roles[1]['image'] as String,
                icon: _roles[1]['icon'] as IconData,
                onTap: () => context.push(
                  '/register',
                  extra: _roles[1]['role'] as String,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
