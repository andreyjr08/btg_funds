import 'package:btg_funds_app/core/errors/failures.dart';
import 'package:btg_funds_app/core/utils/currency_formatter.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

class SubscribeToFund {
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
