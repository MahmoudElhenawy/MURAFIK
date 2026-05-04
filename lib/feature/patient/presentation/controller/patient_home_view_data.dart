import 'package:flutter/material.dart';

class PatientHomeViewData {
  final String patientName;
  final String greeting;
  final DoctorInfo? doctor;
  final List<SensorReadingViewData> sensors;
  final List<PatientAlertViewData> alerts;
  final DeviceStatusViewData? deviceStatus;

  static const preview = PatientHomeViewData(
    patientName: 'mahmoud elhenawy',
    greeting: 'Good morning',
    doctor: DoctorInfo(
      name: 'Dr. Mohamed Salah',
      specialty: 'Neurology · Cairo Medical Center',
      phone: '01000000000',
    ),
    sensors: [
      SensorReadingViewData(
        name: 'ECG',
        fullName: 'ECG',
        description: 'قراءات النشاط الكهربائي للقلب',
        value: '72',
        unit: 'bpm',
        icon: Icons.monitor_heart_outlined,
        iconBg: Color(0xFFEFF6FF),
        iconColor: Color(0xFF2563EB),
        status: SensorStatus.normal,
      ),
      SensorReadingViewData(
        name: 'EMG',
        fullName: 'EMG',
        description: 'قراءات النشاط الكهربائي للعضلات',
        value: '0.8',
        unit: 'mV',
        icon: Icons.electric_bolt_outlined,
        iconBg: Color(0xFFF5F3FF),
        iconColor: Color(0xFF7C3AED),
        status: SensorStatus.elevated,
      ),
      SensorReadingViewData(
        name: 'Accel & Gyro',
        fullName: 'Accelerometer & Gyroscope',
        description: 'قراءات الحركة والاتجاه (لكشف النوبات)',
        value: '0.2',
        unit: 'g',
        icon: Icons.sensors_outlined,
        iconBg: Color(0xFFECFDF5),
        iconColor: Color(0xFF059669),
        status: SensorStatus.normal,
      ),
      SensorReadingViewData(
        name: 'Temperature',
        fullName: 'Temperature Sensor',
        description: 'قراءات درجة حرارة الجسم',
        value: '37.2',
        unit: '°C',
        icon: Icons.thermostat_outlined,
        iconBg: Color(0xFFFFF7ED),
        iconColor: Color(0xFFEA580C),
        status: SensorStatus.normal,
      ),
      SensorReadingViewData(
        name: 'GSR',
        fullName: 'GSR (Galvanic Skin Response)',
        description:
            'بيقيس مقاومة الجلد الكهربائية، مرتبطة بالتوتر والإجهاد وبتساعد في كشف النوبات',
        value: '420',
        unit: 'kΩ',
        icon: Icons.monitor_heart_outlined,
        iconBg: Color(0xFFEFF6FF),
        iconColor: Color(0xFF1D4ED8),
        status: SensorStatus.normal,
      ),
      SensorReadingViewData(
        name: 'NIR',
        fullName: 'NIR (Near-Infrared)',
        description: 'قياس SpO₂ و PPG (زي حساسات MAX30102)',
        value: '97',
        unit: '%',
        icon: Icons.bloodtype_outlined,
        iconBg: Color(0xFFFEF2F2),
        iconColor: Color(0xFFDC2626),
        status: SensorStatus.normal,
      ),
    ],
    alerts: [
      PatientAlertViewData(
        title: 'High EMG activity detected',
        description: 'Abnormal muscle activity — possible seizure event',
        time: '10:32',
        severity: AlertSeverity.critical,
      ),
      PatientAlertViewData(
        title: 'Heart rate elevated',
        description: 'ECG reading above resting threshold for 5 min',
        time: '09:15',
        severity: AlertSeverity.warning,
      ),
      PatientAlertViewData(
        title: 'Device battery low',
        description: 'Wearable device at 15% — please charge soon',
        time: 'Yesterday',
        severity: AlertSeverity.info,
      ),
    ],
    deviceStatus: DeviceStatusViewData(
      label: 'Device connected',
      isConnected: true,
    ),
  );

  const PatientHomeViewData({
    required this.patientName,
    required this.greeting,
    this.doctor,
    required this.sensors,
    required this.alerts,
    this.deviceStatus,
  });

  static const empty = PatientHomeViewData(
    patientName: '',
    greeting: '',
    doctor: null,
    sensors: [],
    alerts: [],
    deviceStatus: null,
  );
}

class DoctorInfo {
  final String name;
  final String specialty;
  final String phone;

  const DoctorInfo({
    required this.name,
    required this.specialty,
    required this.phone,
  });
}

class SensorReadingViewData {
  final String name;
  final String fullName;
  final String description;
  final String value;
  final String unit;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final SensorStatus status;

  const SensorReadingViewData({
    required this.name,
    required this.fullName,
    required this.description,
    required this.value,
    required this.unit,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.status,
  });
}

class PatientAlertViewData {
  final String title;
  final String description;
  final String time;
  final AlertSeverity severity;

  const PatientAlertViewData({
    required this.title,
    required this.description,
    required this.time,
    required this.severity,
  });
}

class DeviceStatusViewData {
  final String label;
  final bool isConnected;

  const DeviceStatusViewData({required this.label, required this.isConnected});
}

enum SensorStatus { normal, elevated, alert }

enum AlertSeverity { info, warning, critical }
