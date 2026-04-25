import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/feature/auth/presentation/widgets/quick_login_grid.dart';

class ChoseUser extends StatelessWidget {
  const ChoseUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
              child: Column(
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Image.asset('assets/images/logo.png', height: 200),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Welcome to Murafik',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Choose your role to get started',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 28),

                  const QuickLoginGrid(),

                  const SizedBox(height: 28),

                  // Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/login'),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF007DFE),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
