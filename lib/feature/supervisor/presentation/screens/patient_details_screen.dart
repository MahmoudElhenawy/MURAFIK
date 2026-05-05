import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/service_locator/service_locator.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/core/util/primary_button.dart';
import 'package:murafik/feature/doctor/domain/entities/doctor_reading_entity.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_patient_readings_usecase.dart';
import 'package:murafik/feature/supervisor/presentation/widgets/row_info_patient.dart';
import 'package:murafik/feature/doctor/presentation/widgets/reading_card.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String registrationDate;
  final String doctor;
  final String phone;
  final String address;
  final String status;
  final String deviceSerial;
  final bool isDoctor;
  final int? patientId;

  const PatientDetailsScreen({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.registrationDate,
    required this.doctor,
    this.phone = '',
    this.address = '',
    this.status = '',
    this.deviceSerial = '',
    this.isDoctor = false,
    this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.split(" ").take(2).map((e) => e[0]).join().toUpperCase()
        : "NA";

    final infoItems = <_InfoItem>[
      if (_hasText(age))
        const _InfoItem(
          icon: Icons.person_outline_rounded,
          iconBg: Color(0xFFEFF6FF),
          iconColor: Color(0xFF1A7FE8),
          title: 'Age',
          valueKey: 'age',
        ),
      if (_hasText(gender))
        const _InfoItem(
          icon: Icons.wc_rounded,
          iconBg: Color(0xFFF0FDF4),
          iconColor: Color(0xFF16A34A),
          title: 'Gender',
          valueKey: 'gender',
        ),
      if (_hasText(registrationDate))
        const _InfoItem(
          icon: Icons.calendar_today_rounded,
          iconBg: Color(0xFFFFF7ED),
          iconColor: Color(0xFFEA580C),
          title: 'Reg. Date',
          valueKey: 'registrationDate',
        ),
      if (_hasText(doctor))
        const _InfoItem(
          icon: Icons.local_hospital_rounded,
          iconBg: Color(0xFFFDF4FF),
          iconColor: Color(0xFF9333EA),
          title: 'Doctor',
          valueKey: 'doctor',
        ),
      if (_hasText(phone))
        const _InfoItem(
          icon: Icons.phone_rounded,
          iconBg: Color(0xFFEFF6FF),
          iconColor: Color(0xFF1D4ED8),
          title: 'Phone',
          valueKey: 'phone',
        ),
      if (_hasText(address))
        const _InfoItem(
          icon: Icons.location_on_outlined,
          iconBg: Color(0xFFF0FDF4),
          iconColor: Color(0xFF16A34A),
          title: 'Address',
          valueKey: 'address',
        ),
      if (_hasText(status))
        const _InfoItem(
          icon: Icons.favorite_outline,
          iconBg: Color(0xFFFFF1F2),
          iconColor: Color(0xFFE11D48),
          title: 'Status',
          valueKey: 'status',
        ),
      if (_hasText(deviceSerial))
        const _InfoItem(
          icon: Icons.memory_outlined,
          iconBg: Color(0xFFF5F3FF),
          iconColor: Color(0xFF7C3AED),
          title: 'Device',
          valueKey: 'deviceSerial',
        ),
    ];

    String _resolveValue(String key) {
      switch (key) {
        case 'age':
          return age;
        case 'gender':
          return gender;
        case 'registrationDate':
          return registrationDate;
        case 'doctor':
          return doctor;
        case 'phone':
          return phone;
        case 'address':
          return address;
        case 'status':
          return status;
        case 'deviceSerial':
          return deviceSerial;
        default:
          return '';
      }
    }

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

                if (infoItems.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < infoItems.length; i++)
                          RowInfoPatient(
                            icon: infoItems[i].icon,
                            iconBg: infoItems[i].iconBg,
                            iconColor: infoItems[i].iconColor,
                            title: infoItems[i].title,
                            value: _resolveValue(infoItems[i].valueKey),
                            isLast: i == infoItems.length - 1,
                          ),
                      ],
                    ),
                  ),

                // 🧑‍⚕️ Doctor Features
                if (isDoctor) ...[
                  const SizedBox(height: 16),
                  _DoctorReadingsSection(patientId: patientId),
                ],

                // 👨‍💼 Supervisor Button
                if (!isDoctor) ...[
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: "Go To Home",
                    onPressed: () => context.go('/supervisor/home'),
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

class _InfoItem {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String valueKey;

  const _InfoItem({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.valueKey,
  });
}

class _DoctorReadingsSection extends StatelessWidget {
  final int? patientId;

  const _DoctorReadingsSection({required this.patientId});

  @override
  Widget build(BuildContext context) {
    if (patientId == null) {
      return _readingsMessage('No readings available');
    }

    return FutureBuilder(
      future: getIt<GetDoctorPatientReadingsUsecase>().call(
        patientId: patientId!,
        limit: 20,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _readingsMessage('Loading readings...');
        }

        final result = snapshot.data;
        if (result == null) {
          return _readingsMessage('No readings available');
        }

        return result.fold((failure) => _readingsMessage(failure.message), (
          data,
        ) {
          final readings = data.readings;
          if (readings.isEmpty) {
            return _readingsMessage('No readings available');
          }

          final heart = _findLatest(readings, 'Heart Rate');
          final temp = _findLatest(readings, 'Body Temperature');
          final oxygen = _findLatest(readings, 'Blood Oxygen');
          final alert = _findFirstAlert(readings);

          return Column(
            children: [
              Row(
                children: [
                  ReadingCard(
                    title: 'Heart',
                    value: _formatValue(heart),
                    icon: Icons.favorite,
                    color: Colors.red,
                  ),
                  ReadingCard(
                    title: 'Temp',
                    value: _formatValue(temp),
                    icon: Icons.thermostat,
                    color: Colors.orange,
                  ),
                  ReadingCard(
                    title: 'O2',
                    value: _formatValue(oxygen),
                    icon: Icons.air,
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _alertBanner(alert),
            ],
          );
        });
      },
    );
  }

  static DoctorReadingEntity? _findLatest(
    List<DoctorReadingEntity> readings,
    String sensorName,
  ) {
    final target = sensorName.toLowerCase();
    DoctorReadingEntity? latest;
    for (final reading in readings) {
      if (reading.sensorName.toLowerCase() != target) {
        continue;
      }
      if (latest == null) {
        latest = reading;
        continue;
      }
      final currentTs = reading.timeStamp?.millisecondsSinceEpoch ?? 0;
      final latestTs = latest.timeStamp?.millisecondsSinceEpoch ?? 0;
      if (currentTs > latestTs) {
        latest = reading;
      }
    }
    return latest;
  }

  static DoctorReadingEntity? _findFirstAlert(
    List<DoctorReadingEntity> readings,
  ) {
    DoctorReadingEntity? latestAlert;
    for (final reading in readings) {
      if (!reading.hasAlert) {
        continue;
      }
      if (latestAlert == null) {
        latestAlert = reading;
        continue;
      }
      final currentTs = reading.timeStamp?.millisecondsSinceEpoch ?? 0;
      final latestTs = latestAlert.timeStamp?.millisecondsSinceEpoch ?? 0;
      if (currentTs > latestTs) {
        latestAlert = reading;
      }
    }
    return latestAlert;
  }

  static String _formatValue(DoctorReadingEntity? reading) {
    if (reading == null) return '--';
    final unit = reading.unit.trim();
    if (unit.isEmpty) return reading.value;
    return '${reading.value} $unit';
  }

  static String _formatAlertTitle(DoctorReadingEntity alert) {
    final type = alert.alertType?.toLowerCase() ?? 'alert';
    final severity = type == 'high' || type == 'critical' ? 'High' : 'Low';
    return '$severity ${alert.sensorName}';
  }

  static Widget _alertBanner(DoctorReadingEntity? alert) {
    final hasAlert = alert != null;
    final message = hasAlert
        ? '${_formatAlertTitle(alert)}: ${_formatValue(alert)}'
        : 'No alerts right now';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            hasAlert ? Icons.warning : Icons.check_circle_outline,
            color: hasAlert ? Colors.red : const Color(0xFF16A34A),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }

  static Widget _readingsMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF64748B)),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

bool _hasText(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return false;
  return trimmed.toUpperCase() != 'N/A';
}
