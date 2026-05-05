import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String condition;
  final String? age;
  final String status;

  // 👇 دول اللي كانوا ناقصين
  final String gender;
  final String registrationDate;
  final String doctor;
  final VoidCallback? onDetailsTap;

  const PatientCard({
    super.key,
    required this.name,
    required this.condition,
    this.age,
    this.status = "Stable",
    required this.gender,
    required this.registrationDate,
    required this.doctor,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.split(" ").take(2).map((e) => e[0]).join().toUpperCase()
        : "NA";

    final isStable = status.toLowerCase() == "stable";
    final hasCondition = _hasText(condition);
    final hasAge = _hasText(age);
    final hasDetails =
        _hasText(age) ||
        _hasText(gender) ||
        _hasText(registrationDate) ||
        _hasText(doctor);

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 👤 Avatar
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEFF6FF),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 📄 Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 6),

                if (hasCondition) ...[
                  Text(
                    condition,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],

                if (hasAge) ...[
                  const SizedBox(height: 4),
                  Text(
                    "Age: $age",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 8),

          // 🟢 Status + Arrow
          Row(
            children: [
              if (_hasText(status))
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isStable
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      color: isStable ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              if (hasDetails) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap:
                      onDetailsTap ??
                      () {
                        context.push(
                          '/patient/details',
                          extra: {
                            'name': name,
                            'age': age ?? '',
                            'gender': gender,
                            'registrationDate': registrationDate,
                            'doctor': doctor,
                          },
                        );
                      },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  static bool _hasText(String? value) {
    if (value == null) return false;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    return trimmed.toUpperCase() != 'N/A';
  }
}
