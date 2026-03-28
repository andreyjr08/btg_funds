import 'package:flutter_riverpod/legacy.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, List<FundTransaction>>(
      (ref) => TransactionsNotifier(),
    );

class TransactionsNotifier extends StateNotifier<List<FundTransaction>> {
  TransactionsNotifier() : super([]);

  void addTransaction(FundTransaction tx) {
    state = [...state, tx];
  }
}
