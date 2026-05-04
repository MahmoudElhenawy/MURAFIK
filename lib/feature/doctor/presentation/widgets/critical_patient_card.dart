// critical_patient_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CriticalPatientCard extends StatelessWidget {
  final String name;
  final String condition;

  const CriticalPatientCard({
    super.key,
    required this.name,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(" ")
        .take(2)
        .map((e) => e[0])
        .join()
        .toUpperCase();

    return GestureDetector(
      onTap: () {
        context.push(
          '/PatientDetailsScreen',
          extra: {
            'name': name,
            'age': "45",
            'gender': "Male",
            'registrationDate': "2024-01-10",
            'doctor': "Dr. Ahmed",
            'isDoctor': true,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE24B4A).withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A7FE8), Color(0xFF0847A8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE24B4A),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        condition,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE24B4A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFCBD5E1),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
