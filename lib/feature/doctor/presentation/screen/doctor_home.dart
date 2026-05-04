import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/drawer/custom_drawer.dart';
import 'package:murafik/core/drawer/drawer_items_helper.dart';
import 'package:murafik/core/drawer/user_role.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/core/util/primary_button.dart';
import 'package:murafik/core/widgets/notification_icon.dart';
import 'package:murafik/feature/doctor/presentation/widgets/critical_patient_card.dart';
import 'package:murafik/feature/doctor/presentation/widgets/stat_card.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_section.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        userName: "Dr. Ahmed",
        role: "Doctor",
        items: getDrawerItems(context, UserRole.doctor),
      ),

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Doctor ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kPGradient),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: NotificationIcon(),
          ),
        ],
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 📊 Stats
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.push('/doctor/patients'),
                        child: const StatCard(
                          icon: Icons.people_rounded,
                          title: "Patients",
                          value: "120",
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.push('/doctor/alerts'),
                        child: const StatCard(
                          icon: Icons.notifications_rounded,
                          title: "Alerts",
                          value: "8",
                          color: Color(0xFFE24B4A),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🚨 Section Title
                PatientHomeSection(
                  title: 'Critical Cases',
                  actionLabel: 'See All',
                  onAction: () => context.push('/doctor/critical'),
                ),

                const SizedBox(height: 12),

                // 📋 Critical Patients List
                Expanded(
                  child: ListView(
                    children: const [
                      CriticalPatientCard(
                        name: "Ali Hassan",
                        condition: "High Heart Rate",
                      ),
                      CriticalPatientCard(
                        name: "Omar Samy",
                        condition: "Low Oxygen",
                      ),
                      CriticalPatientCard(
                        name: "Sara Ahmed",
                        condition: "High Temperature",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  onPressed: () => context.push('/supervisorHome'),
                  text: 'Go To Supervisor Home',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
