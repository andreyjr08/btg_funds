import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/domain/usecases/subscribe_to_fund.dart';
import 'package:btg_funds_app/presentation/providers/wallet_provider.dart';
import 'package:btg_funds_app/presentation/providers/usecases_providers.dart';
import 'package:btg_funds_app/presentation/providers/transactions_provider.dart';
import 'package:btg_funds_app/presentation/providers/repositories_providers.dart';

final fundsViewModelProvider =
    AsyncNotifierProvider<FundsViewModel, List<FundEntity>>(FundsViewModel.new);

class FundsViewModel extends AsyncNotifier<List<FundEntity>> {
  late final SubscribeToFund _subscribe;

  @override
  Future<List<FundEntity>> build() async {
    final repo = ref.read(fundsRepositoryProvider);

    _subscribe = ref.read(subscribeUseCaseProvider);

    return repo.getFunds();
  }

  void subscribe(FundEntity fund, double amount) {
    final wallet = ref.read(walletProvider);
    final walletNotifier = ref.read(walletProvider.notifier);
    final txNotifier = ref.read(transactionsProvider.notifier);

    try {
      _subscribe.execute(
        currentBalance: wallet,
        amount: amount,
        minAmount: fund.minAmount,
        onSuccessSubtract: (value) => walletNotifier.subtract(value),
        onTransaction: (tx) => txNotifier.addTransaction(tx),
      );
    } catch (e) {
      rethrow;
    }
  }
}
