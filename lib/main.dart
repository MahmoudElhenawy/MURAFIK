import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/core/util/app_router.dart';
import 'package:murafik/core/service_locator/service_locator.dart';
import 'package:murafik/feature/auth/presentation/cubit/auth_cubit.dart';

void main() {
  setupServiceLocator();
  runApp(const MURAFIK());
}

class MURAFIK extends StatelessWidget {
  const MURAFIK({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
