import 'package:flutter/material.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/widgets/sensor_card.dart';

class PatientSensorGrid extends StatelessWidget {
  final List<SensorReadingViewData> sensors;
  final VoidCallback onSensorTap;

  const PatientSensorGrid({
    super.key,
    required this.sensors,
    required this.onSensorTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 14,
          childAspectRatio: 1.4,
        ),
        itemCount: sensors.length,
        itemBuilder: (context, i) {
          final sensor = sensors[i];
          return SensorCard(
            name: sensor.name,
            value: sensor.value,
            unit: sensor.unit,
            icon: sensor.icon,
            iconBg: sensor.iconBg,
            iconColor: sensor.iconColor,
            status: sensor.status,
            onTap: onSensorTap,
          );
        },
      ),
    );
  }
}
