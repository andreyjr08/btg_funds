import 'package:flutter/material.dart';
import 'package:btg_funds_app/presentation/routes/app_router.dart';

/// Widget principal de la aplicación.
/// Configura MaterialApp con enrutamiento mediante GoRouter.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
