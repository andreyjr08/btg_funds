import 'package:flutter/material.dart';
import 'package:btg_funds_app/presentation/routes/app_router.dart';

/// Main application widget.
/// Configures the MaterialApp with routing using GoRouter.
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
