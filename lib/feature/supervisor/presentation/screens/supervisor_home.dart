import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/service_locator/service_locator.dart';
import 'package:murafik/core/util/primary_button.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_alerts_list.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_card.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_header.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_section.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_sensor_grid.dart';
import 'package:murafik/feature/supervisor/presentation/controller/supervisor_home_cubit.dart';
import 'package:murafik/feature/supervisor/presentation/controller/supervisor_home_view_data.dart';

class SupervisorHome extends StatelessWidget {
  const SupervisorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SupervisorHomeCubit>()..load(),
      child: BlocBuilder<SupervisorHomeCubit, SupervisorHomeState>(
        builder: (context, state) {
          final viewData = state.data;
          final patientData = _asPatientViewData(viewData);

          return Scaffold(
            backgroundColor: const Color(0xFFF1F5F9),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/background.png', fit: BoxFit.cover),
                if (state.status == SupervisorHomeStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == SupervisorHomeStatus.failure)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 40,
                            color: Color(0xFFE24B4A),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.message ?? 'Failed to load data',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<SupervisorHomeCubit>().load(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  CustomScrollView(
                    slivers: [
                      PatientHomeHeader(
                        patientName: viewData.supervisorName,
                        greeting: viewData.supervisorRole.isNotEmpty
                            ? viewData.supervisorRole
                            : 'Supervisor',
                        onNotificationsPressed: () =>
                            _goToAlerts(context, patientData),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            PatientHomeSection(
                              title: 'Current patient',
                              headerSpacing: 10,
                              actionLabel: null,
                              child: viewData.patient != null
                                  ? PatientCard(
                                      name: viewData.patient!.name,
                                      condition: _doctorLabel(
                                        viewData.patient!.doctorName,
                                      ),
                                      age: viewData.patient!.age,
                                      status: viewData.patient!.status,
                                      gender: viewData.patient!.gender,
                                      registrationDate: '',
                                      doctor: viewData.patient!.doctorName,
                                    )
                                  : const _EmptyPatientCard(),
                            ),

                            const SizedBox(height: 22),

                            PatientHomeSection(
                              title: 'Latest readings',
                              actionLabel: viewData.sensors.isNotEmpty
                                  ? 'See all'
                                  : null,
                              onAction: viewData.sensors.isNotEmpty
                                  ? () => _goToReadings(context, patientData)
                                  : null,
                              headerSpacing: 12,
                              child: viewData.sensors.isNotEmpty
                                  ? PatientSensorGrid(
                                      sensors: viewData.sensors,
                                      onSensorTap: _noop,
                                    )
                                  : const _EmptyReadingsCard(),
                            ),

                            const SizedBox(height: 22),

                            PatientHomeSection(
                              title: 'Alerts',
                              actionLabel: viewData.alerts.isNotEmpty
                                  ? 'See all'
                                  : null,
                              onAction: viewData.alerts.isNotEmpty
                                  ? () => _goToAlerts(context, patientData)
                                  : null,
                              headerSpacing: 10,
                              child: viewData.alerts.isNotEmpty
                                  ? PatientAlertsList(alerts: viewData.alerts)
                                  : const _EmptyAlertsCard(),
                            ),

                            const SizedBox(height: 40),
                            PrimaryButton(
                              text: 'Go To Choose Role',
                              onPressed: () =>
                                  context.push('/choose-role', extra: viewData),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  static void _noop() {}

  static void _goToReadings(BuildContext context, PatientHomeViewData data) {
    context.push('/patient/readings', extra: data);
  }

  static void _goToAlerts(BuildContext context, PatientHomeViewData data) {
    context.push('/patient/alerts', extra: data);
  }

  static PatientHomeViewData _asPatientViewData(SupervisorHomeViewData data) {
    return PatientHomeViewData(
      patientName: data.patient?.name ?? '',
      greeting: '',
      doctor: null,
      sensors: data.sensors,
      alerts: data.alerts,
      deviceStatus: null,
    );
  }

  static String _doctorLabel(String doctorName) {
    final trimmed = doctorName.trim();
    if (trimmed.isEmpty || trimmed.toUpperCase() == 'N/A') {
      return '';
    }
    return 'Doctor: $trimmed';
  }
}

class _EmptyPatientCard extends StatelessWidget {
  const _EmptyPatientCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.person_off_outlined, color: Color(0xFF64748B)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'No patient assigned',
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyReadingsCard extends StatelessWidget {
  const _EmptyReadingsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.sensors_off_outlined, color: Color(0xFF64748B)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'No readings available',
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyAlertsCard extends StatelessWidget {
  const _EmptyAlertsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.notifications_off_outlined, color: Color(0xFF64748B)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'No alerts available',
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }
}
