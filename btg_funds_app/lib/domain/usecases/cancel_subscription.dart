import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

class CancelSubscription {
  void execute({
    required double investedAmount,
    required void Function(double) onRefund,
    required void Function() onRemoveSubscription,
    required void Function(FundTransaction) onTransaction,
    required int fundId,
  }) {
    if (investedAmount <= 0) {
      throw Exception("No hay suscripción activa");
    }

    onRefund(investedAmount);

    onRemoveSubscription();

    onTransaction(
      FundTransaction(
        fundId: fundId,
        amount: investedAmount,
        type: TransactionType.cancel,
        date: DateTime.now(),
      ),
    );
  }
}
