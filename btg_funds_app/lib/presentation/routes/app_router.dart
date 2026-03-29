import 'package:go_router/go_router.dart';
import 'package:btg_funds_app/presentation/screens/funds_screen.dart';
import 'package:btg_funds_app/presentation/screens/transactions_screen.dart';

/// Configuración del enrutador de la aplicación.
/// Define todas las rutas disponibles y sus constructores de páginas.
/// Utiliza GoRouter para la navegación basada en rutas.
final appRouter = GoRouter(
  routes: [
    /// Ruta raíz que muestra la pantalla de fondos.
    GoRoute(path: '/', builder: (context, state) => const FundsScreen()),
    
    /// Ruta para la pantalla de historial de transacciones.
    GoRoute(path: '/transactions', builder: (_, _) => TransactionsScreen()),
  ],
);
