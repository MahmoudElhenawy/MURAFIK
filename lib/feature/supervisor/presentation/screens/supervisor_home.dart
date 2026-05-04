import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/drawer/drawer_items_helper.dart';
import 'package:murafik/core/drawer/user_role.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/core/drawer/custom_drawer.dart';
import 'package:murafik/core/widgets/notification_icon.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_alerts_list.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_card.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_home_section.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_sensor_grid.dart';
import 'package:murafik/feature/supervisor/presentation/controller/supervisor_home_cubit.dart';

class SupervisorHome extends StatelessWidget {
  const SupervisorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SupervisorHomeCubit(),
      child: BlocBuilder<SupervisorHomeCubit, SupervisorHomeState>(
        builder: (context, state) {
          final viewData = state.data;

          return Scaffold(
            drawer: CustomDrawer(
              userName: "Ahmed Mohamed",
              role: "Supervisor",
              items: getDrawerItems(context, UserRole.supervisor),
            ),
            appBar: AppBar(
              title: const Text(
                "Supervisor",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: const BoxDecoration(gradient: kPGradient),
              ),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: NotificationIcon(),
                ),
              ],
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/background.png', fit: BoxFit.cover),
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          PatientHomeSection(
                            title: 'Current patient',
                            headerSpacing: 10,
                            actionLabel: 'See all',
                            child: PatientCard(
                              name: "mahmoud elhenawy",
                              condition: "Heart Disease",
                              age: "22",
                              status: "Stable",
                              gender: "Male",
                              registrationDate: "2026-01-01",
                              doctor: "Dr.mahmoud",
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
