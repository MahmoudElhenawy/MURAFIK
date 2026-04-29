import 'package:flutter/material.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/widgets/alart_item.dart';

class PatientAlertsList extends StatelessWidget {
  final List<PatientAlertViewData> alerts;

  const PatientAlertsList({super.key, required this.alerts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final alert in alerts)
          AlertItemWidget(
            title: alert.title,
            description: alert.description,
            time: alert.time,
            severity: alert.severity,
          ),
      ],
    );
  }
}
