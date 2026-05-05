import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/core/service_locator/service_locator.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_alerts_cubit.dart';
import 'package:murafik/feature/doctor/presentation/widgets/alert_card.dart';

class DoctorAlertsScreen extends StatelessWidget {
  const DoctorAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorAlertsCubit>()..load(),
      child: BlocBuilder<DoctorAlertsCubit, DoctorAlertsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                "All Alerts",
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
                if (state.status == DoctorAlertsStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == DoctorAlertsStatus.failure)
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
                                context.read<DoctorAlertsCubit>().load(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state.alerts.isEmpty)
                  const Center(
                    child: Text(
                      'No alerts available',
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),
                  )
                else
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.alerts.length,
                    itemBuilder: (context, index) {
                      final alert = state.alerts[index];
                      return AlertCard(
                        title: alert.title,
                        patient: alert.patientName,
                        time: alert.time,
                        isCritical: alert.isCritical,
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
