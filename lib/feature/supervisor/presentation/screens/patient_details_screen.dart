import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/core/util/primary_button.dart';
import 'package:murafik/feature/supervisor/presentation/widgets/row_info_patient.dart';
import 'package:murafik/feature/doctor/presentation/widgets/reading_card.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String registrationDate;
  final String doctor;
  final bool isDoctor;

  const PatientDetailsScreen({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.registrationDate,
    required this.doctor,
    this.isDoctor = false,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.split(" ").take(2).map((e) => e[0]).join().toUpperCase()
        : "NA";

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Patient Details"),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kPGradient),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              children: [
                // 👤 Profile
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: kPGradient,
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Patient",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // 📄 Info Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      RowInfoPatient(
                        icon: Icons.person_outline_rounded,
                        iconBg: const Color(0xFFEFF6FF),
                        iconColor: const Color(0xFF1A7FE8),
                        title: "Age",
                        value: age,
                      ),
                      RowInfoPatient(
                        icon: Icons.wc_rounded,
                        iconBg: const Color(0xFFF0FDF4),
                        iconColor: const Color(0xFF16A34A),
                        title: "Gender",
                        value: gender,
                      ),
                      RowInfoPatient(
                        icon: Icons.calendar_today_rounded,
                        iconBg: const Color(0xFFFFF7ED),
                        iconColor: const Color(0xFFEA580C),
                        title: "Reg. Date",
                        value: registrationDate,
                      ),
                      RowInfoPatient(
                        icon: Icons.local_hospital_rounded,
                        iconBg: const Color(0xFFFDF4FF),
                        iconColor: const Color(0xFF9333EA),
                        title: "Doctor",
                        value: doctor,
                        isLast: true,
                      ),
                    ],
                  ),
                ),

                // 🧑‍⚕️ Doctor Features
                if (isDoctor) ...[
                  const SizedBox(height: 16),

                  // 📊 Readings
                  Row(
                    children: const [
                      ReadingCard(
                        title: "Heart",
                        value: "85 bpm",
                        icon: Icons.favorite,
                        color: Colors.red,
                      ),
                      ReadingCard(
                        title: "Temp",
                        value: "37 °C",
                        icon: Icons.thermostat,
                        color: Colors.orange,
                      ),
                      ReadingCard(
                        title: "O2",
                        value: "98%",
                        icon: Icons.air,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 🚨 Alerts
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(child: Text("High heart rate detected")),
                      ],
                    ),
                  ),
                ],

                // 👨‍💼 Supervisor Button
                if (!isDoctor) ...[
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: "Go To Home",
                    onPressed: () => context.go('/supervisorHome'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
