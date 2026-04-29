import 'package:go_router/go_router.dart';
import 'package:murafik/feature/auth/presentation/screens/chose_user.dart';
import 'package:murafik/feature/auth/presentation/screens/register_screen.dart';
import 'package:murafik/feature/auth/presentation/screens/login_screen.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';
import 'package:murafik/feature/patient/presentation/screen/patient_alerts.dart';
import 'package:murafik/feature/patient/presentation/screen/patient_home.dart';
import 'package:murafik/feature/patient/presentation/screen/patient_readings.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/PatientHome',
    routes: [
      GoRoute(
        path: '/choose-role',
        builder: (context, state) => const ChoseUser(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) {
          final role = state.extra as String;
          return RegisterScreen(role: role);
        },
      ),

      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/PatientHome',
        builder: (context, state) => const PatientHomeScreen(),
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
    ],
  );
}
