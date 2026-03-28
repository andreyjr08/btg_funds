import 'package:btg_funds_app/core/errors/failures.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

class CancelSubscription {
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
