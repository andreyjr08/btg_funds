import 'package:btg_funds_app/core/errors/failures.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

/// Caso de uso para cancelar una suscripción a un fondo de inversión.
/// 
/// Realiza el reembolso del monto invertido, elimina la suscripción del registro
/// y registra una transacción de tipo 'cancel' en el historial.
class CancelSubscription {
  /// Ejecuta la cancelación de una suscripción con reembolso de fondos.
  /// 
  /// Parámetros:
  /// - [investedAmount]: Monto invertido que será reembolsado.
  /// - [fundName]: Nombre del fondo para el registro de transacción.
  /// - [fundId]: Identificador del fondo a cancelar.
  /// - [onRefund]: Callback que suma el monto reembolsado al balance.
  /// - [onRemoveSubscription]: Callback que elimina la suscripción del registro.
  /// - [onTransaction]: Callback que registra la cancelación en historial.
  /// 
  /// Lanza [ValidationFailure] si el monto a reembolsar es <= 0.
  void execute({
    required double investedAmount,
    required String fundName,
    required void Function(double) onRefund,
    required void Function() onRemoveSubscription,
    required void Function(FundTransaction) onTransaction,
    required int fundId,
  }) {
    if (investedAmount <= 0) {
      throw ValidationFailure("El monto a reembolsar debe ser mayor a cero");
    }

    onRefund(investedAmount);

    onRemoveSubscription();

    onTransaction(
      FundTransaction(
        fundId: fundId,
        fundName: fundName,
        amount: investedAmount,
        type: TransactionType.cancel,
        date: DateTime.now(),
      ),
    );
  }
}
