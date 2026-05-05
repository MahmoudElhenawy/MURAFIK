import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/util/constant.dart';
import 'package:murafik/core/service_locator/service_locator.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_patients_cubit.dart';
import 'package:murafik/feature/patient/presentation/widgets/patient_card.dart';

class DoctorPatientsScreen extends StatelessWidget {
  const DoctorPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorPatientsCubit>()..load(),
      child: BlocBuilder<DoctorPatientsCubit, DoctorPatientsState>(
        builder: (context, state) {
          final viewData = state.data;
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(
                "All Patients (${viewData.patients.length})",
                style: const TextStyle(
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
                if (state.status == DoctorPatientsStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == DoctorPatientsStatus.failure)
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
                                context.read<DoctorPatientsCubit>().load(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (viewData.patients.isEmpty)
                  const Center(
                    child: Text(
                      'No patients available',
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),
                  )
                else
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: viewData.patients.length,
                    itemBuilder: (context, index) {
                      final patient = viewData.patients[index];
                      return PatientCard(
                        name: patient.name,
                        condition: patient.condition,
                        age: patient.age,
                        status: patient.status,
                        gender: patient.gender,
                        registrationDate: '',
                        doctor: patient.doctorName,
                        onDetailsTap: () {
                          context.push(
                            '/patient/details',
                            extra: {
                              'patientId': patient.id,
                              'name': patient.name,
                              'age': patient.age ?? '',
                              'gender': patient.gender,
                              'registrationDate': '',
                              'doctor': patient.doctorName,
                              'phone': patient.phone,
                              'address': patient.address,
                              'status': patient.status,
                              'deviceSerial': patient.deviceSerial ?? '',
                              'isDoctor': true,
                            },
                          );
                        },
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
