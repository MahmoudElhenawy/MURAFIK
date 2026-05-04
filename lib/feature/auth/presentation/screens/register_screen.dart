import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:murafik/core/util/custom_text_field.dart';
import 'package:murafik/core/util/primary_button.dart';
import 'package:murafik/feature/auth/presentation/cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  final String role;

  const RegisterScreen({super.key, required this.role});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        role: widget.role,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          _showSnackBar(context, 'Registration successful', isSuccess: true);
          context.go('/login');
        } else if (state is AuthFailure) {
          _showSnackBar(context, state.message, isSuccess: false);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/background.png', fit: BoxFit.cover),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', height: 200),

                      Text(
                        'Register as ${widget.role}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Create your account to get started',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _fieldLabel('Username'),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      hint: 'Enter your username',
                                      controller: _usernameController,
                                      prefixIcon: Icons.person_outline,
                                      validator: (v) {
                                        if (v == null || v.isEmpty)
                                          return 'Username is required';
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    _fieldLabel('Email Address'),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      hint: 'Enter your email',
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Icons.email_outlined,
                                      validator: (v) {
                                        if (v == null || v.isEmpty)
                                          return 'Email is required';
                                        if (!v.contains('@'))
                                          return 'Enter a valid email';
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    _fieldLabel('Phone'),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      hint: 'Enter your phone number',
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: Icons.phone,
                                      validator: (v) {
                                        if (v == null || v.isEmpty)
                                          return 'Phone is required';
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    _fieldLabel('Password'),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      hint: 'Enter your password',
                                      controller: _passwordController,
                                      isPassword: true,
                                      obscureText: _obscurePassword,
                                      prefixIcon: Icons.lock_outline,
                                      onTogglePassword: () {
                                        setState(
                                          () => _obscurePassword =
                                              !_obscurePassword,
                                        );
                                      },
                                      validator: (v) {
                                        if (v == null || v.isEmpty)
                                          return 'Password is required';
                                        if (v.length < 6)
                                          return 'Password must be at least 6 characters';
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    _fieldLabel('Confirm Password'),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      hint: 'Confirm your password',
                                      controller: _confirmPasswordController,
                                      isPassword: true,
                                      obscureText: _obscureConfirmPassword,
                                      prefixIcon: Icons.lock_outline,
                                      onTogglePassword: () {
                                        setState(
                                          () => _obscureConfirmPassword =
                                              !_obscureConfirmPassword,
                                        );
                                      },
                                      validator: (v) {
                                        if (v == null || v.isEmpty)
                                          return 'Please confirm your password';
                                        if (v != _passwordController.text)
                                          return 'Passwords do not match';
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 24),

                                    if (state is AuthLoading)
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    else
                                      PrimaryButton(
                                        text: 'Register',
                                        onPressed: _handleRegister,
                                      ),

                                    const SizedBox(height: 16),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Already have an account? ',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => context.go('/login'),
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Color(0xFF007DFE),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
    );
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    required bool isSuccess,
  }) {
    final backgroundColor = isSuccess ? Colors.green : Colors.red;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }
}
