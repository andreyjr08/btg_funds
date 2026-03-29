import 'package:flutter_riverpod/legacy.dart';

/// Provider de Riverpod que gestiona el estado de la cartera del usuario.
/// 
/// Inicializa con un saldo de 500,000 y proporciona métodos para sumar y restar fondos.
final walletProvider = StateNotifierProvider<WalletNotifier, double>(
  (ref) => WalletNotifier(),
);

/// Notifier que gestiona el estado del saldo disponible en la cartera.
/// 
/// Proporciona métodos para realizar operaciones de suma y resta sobre el balance.
class WalletNotifier extends StateNotifier<double> {
  /// Crea un [WalletNotifier] con saldo inicial de 500,000.
  WalletNotifier() : super(500000);

  /// Resta un monto del saldo actual.
  /// 
  /// Parámetro [amount]: Cantidad a restar del balance.
  void subtract(double amount) {
    state -= amount;
  }

  /// Suma un monto al saldo actual.
  /// 
  /// Parámetro [amount]: Cantidad a sumar al balance.
  void add(double amount) {
    state += amount;
  }
}
