import 'package:flutter/material.dart';
import 'package:murafik/core/app_router.dart';

void main() {
  runApp(const MURAFIK());
}

class MURAFIK extends StatelessWidget {
  const MURAFIK({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
