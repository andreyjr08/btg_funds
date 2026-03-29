import 'package:flutter_riverpod/legacy.dart';

/// Provider de Riverpod que gestiona el estado de suscripciones del usuario.
/// 
/// Almacena las suscripciones activas como pares fundId -> monto invertido.
final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, Map<int, double>>(
      (ref) => SubscriptionsNotifier(),
    );

/// Notifier que gestiona el estado de las suscripciones activas a fondos.
/// 
/// Mantiene un registro de qué fondos están suscritos y los montos invertidos.
class SubscriptionsNotifier extends StateNotifier<Map<int, double>> {
  /// Crea un [SubscriptionsNotifier] con mapa de suscripciones vacío.
  SubscriptionsNotifier() : super({});

  /// Agrega o actualiza una suscripción a un fondo.
  /// 
  /// Parámetros:
  /// - [fundId]: Identificador del fondo.
  /// - [amount]: Monto invertido en el fondo.
  void subscribe(int fundId, double amount) {
    state = {...state, fundId: (state[fundId] ?? 0) + amount};
  }

  /// Cancela una suscripción a un fondo.
  /// 
  /// Parámetro [fundId]: Identificador del fondo a cancelar.
  void cancel(int fundId) {
    final newState = {...state};
    newState.remove(fundId);
    state = newState;
  }
}
