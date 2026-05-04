import 'package:flutter/material.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_card.dart';

class DoctorPatientsScreen extends StatelessWidget {
  const DoctorPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "All Patients",
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
              PatientCard(
                name: "Ali Hassan",
                condition: "Heart Disease",
                age: "45",
                status: "Critical",
                gender: "Male",
                registrationDate: "2024-01-10",
                doctor: "Dr. Ahmed",
              ),

              PatientCard(
                name: "Omar Samy",
                condition: "Low Oxygen",
                age: "50",
                status: "Stable",
                gender: "Male",
                registrationDate: "2023-12-01",
                doctor: "Dr. Ahmed",
              ),

              PatientCard(
                name: "Sara Ahmed",
                condition: "High Temp",
                age: "30",
                status: "Critical",
                gender: "Female",
                registrationDate: "2024-02-15",
                doctor: "Dr. Ahmed",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
