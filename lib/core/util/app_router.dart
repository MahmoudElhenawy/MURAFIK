import 'package:go_router/go_router.dart';
import 'package:murafik/feature/auth/presentation/screens/chose_user.dart';
import 'package:murafik/feature/auth/presentation/screens/register_screen.dart';
import 'package:murafik/feature/auth/presentation/screens/login_screen.dart';
import 'package:murafik/feature/doctor/presentation/screen/doctor_alerts_screen.dart';
import 'package:murafik/feature/doctor/presentation/screen/doctor_home.dart';
import 'package:murafik/feature/doctor/presentation/screen/doctor_patients_screen.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/screen/patient_alerts.dart';
import 'package:murafik/feature/patient/presentation/screen/patient_home.dart';
import 'package:murafik/feature/patient/presentation/screen/patient_readings.dart';
import 'package:murafik/feature/splash/screens/onboarding_screen.dart';
import 'package:murafik/feature/splash/screens/splash_screen.dart';
import 'package:murafik/feature/supervisor/presentation/screens/patient_details_screen.dart';
import 'package:murafik/feature/supervisor/presentation/screens/supervisor_home.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/choose-role',
        builder: (context, state) => const ChoseUser(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) {
          final extra = state.extra;
          final role = extra is String ? extra : '';
          if (role.isEmpty) {
            return const ChoseUser();
          }
          return RegisterScreen(role: role);
        },
      ),

      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/patient/home',
        builder: (context, state) => const PatientHomeScreen(),
      ),
      GoRoute(
        path: '/patient/details',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final rawId = data?['patientId'];
          final patientId = rawId is int
              ? rawId
              : int.tryParse(rawId?.toString() ?? '');

          return PatientDetailsScreen(
            name: data?['name'] ?? '',
            age: data?['age'] ?? '',
            gender: data?['gender'] ?? '',
            registrationDate: data?['registrationDate'] ?? '',
            doctor: data?['doctor'] ?? '',
            phone: data?['phone'] ?? '',
            address: data?['address'] ?? '',
            status: data?['status'] ?? '',
            deviceSerial: data?['deviceSerial'] ?? '',
            isDoctor: data?['isDoctor'] ?? false,
            patientId: patientId,
          );
        },
      ),
      GoRoute(
        path: '/patient/readings',
        builder: (context, state) {
          final data = state.extra;
          return PatientReadingsScreen(
            data: data is PatientHomeViewData ? data : null,
          );
        },
      ),
      GoRoute(
        path: '/patient/alerts',
        builder: (context, state) {
          final data = state.extra;
          return PatientAlertsScreen(
            data: data is PatientHomeViewData ? data : null,
          );
        },
      ),
      GoRoute(
        path: '/supervisor/home',
        builder: (context, state) => const SupervisorHome(),
      ),
      GoRoute(
        path: '/doctor/home',
        builder: (context, state) => const DoctorHome(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/doctor/patients',
        builder: (context, state) => const DoctorPatientsScreen(),
      ),

      GoRoute(
        path: '/doctor/alerts',
        builder: (context, state) => const DoctorAlertsScreen(),
      ),

      GoRoute(
        path: '/doctor/critical',
        builder: (context, state) => const DoctorPatientsScreen(), // مؤقتًا
      ),
    ],
  );
}
