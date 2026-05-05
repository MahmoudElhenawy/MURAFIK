import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/service_locator/service_locator.dart';
import 'package:murafik/core/util/primary_button.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_home_cubit.dart';
import 'package:murafik/feature/doctor/presentation/widgets/critical_patient_card.dart';
import 'package:murafik/feature/doctor/presentation/widgets/stat_card.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_header.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_section.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorHomeCubit>()..load(),
      child: BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
        builder: (context, state) {
          final viewData = state.data;

          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/background.png', fit: BoxFit.cover),
                if (state.status == DoctorHomeStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == DoctorHomeStatus.failure)
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
                                context.read<DoctorHomeCubit>().load(),
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
                        patientName: viewData.doctorName,
                        greeting: viewData.specialization.isNotEmpty
                            ? viewData.specialization
                            : 'Doctor',
                        onNotificationsPressed: () =>
                            context.push('/doctor/alerts'),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        context.push('/doctor/patients'),
                                    child: StatCard(
                                      icon: Icons.people_rounded,
                                      title: "Patients",
                                      value: viewData.patientsCount.toString(),
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/doctor/alerts'),
                                    child: StatCard(
                                      icon: Icons.notifications_rounded,
                                      title: "Alerts",
                                      value: viewData.totalAlerts.toString(),
                                      color: const Color(0xFFE24B4A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            PatientHomeSection(
                              title: 'Critical Cases',
                              actionLabel: viewData.criticalPatients.isNotEmpty
                                  ? 'See All'
                                  : null,
                              onAction: viewData.criticalPatients.isNotEmpty
                                  ? () => context.push('/doctor/critical')
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            if (viewData.criticalPatients.isNotEmpty)
                              ...viewData.criticalPatients.map((patient) {
                                return CriticalPatientCard(
                                  patientId: patient.patientId,
                                  name: patient.name,
                                  condition: patient.condition,
                                  age: patient.age,
                                  gender: patient.gender,
                                  phone: patient.phone,
                                  alertType: patient.alertType,
                                  currentValue: patient.currentValue,
                                );
                              }),
                            if (viewData.criticalPatients.isEmpty)
                              const _EmptyCriticalCard(),
                            const SizedBox(height: 50),
                            PrimaryButton(
                              text: 'Go To Choose Role',
                              onPressed: () => context.push('/choose-role'),
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
}

class _EmptyCriticalCard extends StatelessWidget {
  const _EmptyCriticalCard();

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
          Icon(Icons.check_circle_outline, color: Color(0xFF16A34A)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'No critical cases right now',
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }
}
