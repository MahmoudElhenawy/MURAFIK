import 'package:flutter/material.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/feature/doctor/presentation/widgets/alert_card.dart';

class DoctorAlertsScreen extends StatelessWidget {
  const DoctorAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "All Alerts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kPGradient),
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),

          ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              AlertCard(
                title: "High Heart Rate",
                patient: "Ali Hassan",
                time: "10:30 AM",
                isCritical: true,
              ),
              AlertCard(
                title: "Low Oxygen",
                patient: "Omar Samy",
                time: "11:00 AM",
                isCritical: true,
              ),
              AlertCard(
                title: "Temperature Rise",
                patient: "Sara Ahmed",
                time: "12:15 PM",
                isCritical: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
