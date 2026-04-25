import 'package:go_router/go_router.dart';
import 'package:murafik/feature/auth/presentation/screens/chose_user.dart';
import 'package:murafik/feature/auth/presentation/screens/register_screen.dart';
import 'package:murafik/feature/auth/presentation/screens/login_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/choose-role',
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
    ],
  );
}
