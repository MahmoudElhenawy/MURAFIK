import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/service_locator/service_locator.dart';
import 'package:murafik/core/util/primary_button.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_cubit.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/widgets/doctor_card.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_alerts_list.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_header.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_section.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_sensor_grid.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientHomeScreen extends StatelessWidget {
  final PatientHomeViewData? data;

  const PatientHomeScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PatientHomeCubit>()..load(),
      child: BlocBuilder<PatientHomeCubit, PatientHomeState>(
        builder: (context, state) {
          final viewData = state.data;

          return Scaffold(
            backgroundColor: const Color(0xFFF1F5F9),
            body: Stack(
              fit: StackFit.expand,

              children: [
                Image.asset('assets/images/background.png', fit: BoxFit.cover),

                if (state.status == PatientHomeStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == PatientHomeStatus.failure)
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
                                context.read<PatientHomeCubit>().load(),
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
                        patientName: viewData.patientName,
                        greeting: viewData.greeting,
                        deviceStatus: viewData.deviceStatus,
                        onNotificationsPressed: () =>
                            _goToAlerts(context, viewData),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            if (viewData.doctor != null)
                              PatientHomeSection(
                                title: 'My Doctor',
                                headerSpacing: 10,
                                child: DoctorCard(
                                  name: viewData.doctor!.name,
                                  specialty: viewData.doctor!.specialty,
                                  onChat:
                                      _canLaunchPhone(viewData.doctor!.phone)
                                      ? () => _launchWhatsApp(
                                          viewData.doctor!.phone,
                                        )
                                      : null,
                                  onCall:
                                      _canLaunchPhone(viewData.doctor!.phone)
                                      ? () =>
                                            _launchPhone(viewData.doctor!.phone)
                                      : null,
                                ),
                              ),

                            if (viewData.doctor != null)
                              const SizedBox(height: 22),

                            if (viewData.sensors.isNotEmpty)
                              PatientHomeSection(
                                title: 'Latest readings',
                                actionLabel: 'See all',
                                onAction: () =>
                                    _goToReadings(context, viewData),
                                headerSpacing: 12,
                                child: PatientSensorGrid(
                                  sensors: viewData.sensors,
                                  onSensorTap: _noop,
                                ),
                              ),

                            if (viewData.sensors.isNotEmpty)
                              const SizedBox(height: 22),

                            PatientHomeSection(
                              title: 'Alerts',
                              actionLabel: viewData.alerts.isNotEmpty
                                  ? 'See all'
                                  : null,
                              onAction: viewData.alerts.isNotEmpty
                                  ? () => _goToAlerts(context, viewData)
                                  : null,
                              headerSpacing: 10,
                              child: viewData.alerts.isNotEmpty
                                  ? PatientAlertsList(alerts: viewData.alerts)
                                  : _EmptyAlertsCard(),
                            ),

                            const SizedBox(height: 50),
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

  static bool _canLaunchPhone(String phone) {
    return phone.trim().isNotEmpty;
  }

  static Future<void> _launchPhone(String phone) async {
    final normalized = _normalizePhone(phone);
    final uri = Uri(scheme: 'tel', path: normalized);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> _launchWhatsApp(String phone) async {
    final normalized = _normalizePhone(phone);
    final uri = Uri.parse('https://wa.me/$normalized');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[^0-9+]'), '');
  }
}

class _EmptyAlertsCard extends StatelessWidget {
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
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              color: Color(0xFF1D4ED8),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'No alerts yet',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
