import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_cubit.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/widgets/doctor_card.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_alerts_list.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_header.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_section.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_sensor_grid.dart';

class PatientHomeScreen extends StatelessWidget {
  final PatientHomeViewData? data;

  const PatientHomeScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PatientHomeCubit(initialData: data),
      child: BlocBuilder<PatientHomeCubit, PatientHomeState>(
        builder: (context, state) {
          final viewData = state.data;

          return Scaffold(
            backgroundColor: const Color(0xFFF1F5F9),
            body: Stack(
              fit: StackFit.expand,

              children: [
                Image.asset('assets/images/background.png', fit: BoxFit.cover),

                CustomScrollView(
                  slivers: [
                    PatientHomeHeader(
                      patientName: viewData.patientName,
                      greeting: viewData.greeting,
                      onNotificationsPressed: () =>
                          _goToAlerts(context, viewData),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          PatientHomeSection(
                            title: 'My Doctor',
                            headerSpacing: 10,
                            child: DoctorCard(
                              name: viewData.doctor.name,
                              specialty: viewData.doctor.specialty,
                              onChat: _noop,
                              onCall: _noop,
                            ),
                          ),

                          const SizedBox(height: 22),

                          PatientHomeSection(
                            title: 'Latest readings',
                            actionLabel: 'See all',
                            onAction: () => _goToReadings(context, viewData),
                            headerSpacing: 12,
                            child: PatientSensorGrid(
                              sensors: viewData.sensors,
                              onSensorTap: _noop,
                            ),
                          ),

                          const SizedBox(height: 22),

                          PatientHomeSection(
                            title: 'Alerts',
                            actionLabel: 'See all',
                            onAction: () => _goToAlerts(context, viewData),
                            headerSpacing: 10,
                            child: PatientAlertsList(alerts: viewData.alerts),
                          ),

                          const SizedBox(height: 24),
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
}
