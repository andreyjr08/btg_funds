import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

class SubscribeToFund {
  void execute({
    required double currentBalance,
    required double amount,
    required double minAmount,
    required void Function(double) onSuccessSubtract,
    required void Function(FundTransaction) onTransaction,
  }) {
    if (currentBalance < amount) {
      throw Exception("Saldo insuficiente");
    }

    if (amount < minAmount) {
      throw Exception("Monto menor al mínimo");
    }

    onSuccessSubtract(amount);

    onTransaction(
      FundTransaction(
        fundId: 0,
        amount: amount,
        type: TransactionType.subscribe,
        date: DateTime.now(),
      ),
    );
  }
}
