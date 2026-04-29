import 'package:flutter/material.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/widgets/alart_item.dart';

class PatientAlertsScreen extends StatelessWidget {
  final PatientHomeViewData? data;

  const PatientAlertsScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final viewData = data ?? PatientHomeViewData.preview;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Alerts'),
        backgroundColor: Colors.blue,
        foregroundColor: const Color(0xFFffffff),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: viewData.alerts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final alert = viewData.alerts[index];
              return AlertItemWidget(
                title: alert.title,
                description: alert.description,
                time: alert.time,
                severity: alert.severity,
              );
            },
          ),
        ],
      ),
    );
  }
}
