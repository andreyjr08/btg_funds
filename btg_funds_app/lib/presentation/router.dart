import 'package:go_router/go_router.dart';
import 'package:btg_funds_app/presentation/screens/funds_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const FundsScreen()),
  ],
);
