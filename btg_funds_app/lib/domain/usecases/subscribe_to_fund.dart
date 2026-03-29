import 'package:btg_funds_app/core/errors/failures.dart';
import 'package:btg_funds_app/core/utils/currency_formatter.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

/// Caso de uso para suscribirse a un fondo de inversión.
/// 
/// Valida que el usuario tenga saldo suficiente y cumpla con el monto mínimo,
/// posteriormente ejecuta los callbacks de sustracción de balance y registro de transacción.
class SubscribeToFund {
  /// Ejecuta la suscripción a un fondo con validaciones de negocio.
  /// 
  /// Parámetros:
  /// - [currentBalance]: Saldo actual disponible en la cartera.
  /// - [amount]: Monto a invertir en el fondo.
  /// - [fundName]: Nombre del fondo para el registro de transacción.
  /// - [minAmount]: Monto mínimo requerido para el fondo.
  /// - [onSuccessSubtract]: Callback ejecutado al validar, sustrae el monto del balance.
  /// - [onTransaction]: Callback que registra la transacción en historial.
  /// 
  /// Lanza [ValidationFailure] si:
  /// - El balance es insuficiente.
  /// - El monto es menor al mínimo requerido.
  void execute({
    required double currentBalance,
    required double amount,
    required String fundName,
    required double minAmount,
    required void Function(double) onSuccessSubtract,
    required void Function(FundTransaction) onTransaction,
  }) {
    if (currentBalance < amount) {
      throw ValidationFailure("Saldo insuficiente para la operación");
    }

    if (amount < minAmount) {
      throw ValidationFailure(
        "El monto debe ser mayor o igual que ${CurrencyFormatter.format(minAmount)}",
      );
    }

    onSuccessSubtract(amount);

    onTransaction(
      FundTransaction(
        fundId: 0,
        fundName: fundName,
        amount: amount,
        type: TransactionType.subscribe,
        date: DateTime.now(),
      ),
    );
  }
}
