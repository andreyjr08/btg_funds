import 'package:btg_funds_app/presentation/screens/transactions_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:btg_funds_app/presentation/screens/funds_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const FundsScreen()),
    GoRoute(path: '/transactions', builder: (_, __) => TransactionsScreen()),
  ],
);
