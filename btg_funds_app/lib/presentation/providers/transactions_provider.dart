import 'package:flutter_riverpod/legacy.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

/// Provider de Riverpod que gestiona el historial de transacciones.
/// 
/// Mantiene una lista de todas las transacciones (suscripciones y cancelaciones).
final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, List<FundTransaction>>(
      (ref) => TransactionsNotifier(),
    );

/// Notifier que gestiona el estado del historial de transacciones.
/// 
/// Proporciona métodos para agregar nuevas transacciones al historial.
class TransactionsNotifier extends StateNotifier<List<FundTransaction>> {
  /// Crea un [TransactionsNotifier] con lista de transacciones vacía.
  TransactionsNotifier() : super([]);

  /// Agrega una nueva transacción al historial.
  /// 
  /// Parámetro [tx]: La transacción a agregar (suscripción o cancelación).
  void addTransaction(FundTransaction tx) {
    state = [...state, tx];
  }
}
