import 'package:btg_funds_app/core/errors/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/domain/usecases/subscribe_to_fund.dart';
import 'package:btg_funds_app/presentation/providers/wallet_provider.dart';
import 'package:btg_funds_app/presentation/providers/usecases_providers.dart';
import 'package:btg_funds_app/presentation/providers/transactions_provider.dart';
import 'package:btg_funds_app/presentation/providers/subscriptions_provider.dart';
import 'package:btg_funds_app/presentation/providers/repositories_providers.dart';

/// Provider que expone el ViewModel de fondos.
/// 
/// Retorna una lista asíncrona de fondos disponibles.
final fundsViewModelProvider =
    AsyncNotifierProvider<FundsViewModel, List<FundEntity>>(FundsViewModel.new);

/// ViewModel que orquesta la lógica de negocio para fondos de inversión.
/// 
/// Proporciona métodos para cargar fondos, suscribirse y cancelar suscripciones,
/// coordinando entre repositorios, casos de uso y providers de estado.
class FundsViewModel extends AsyncNotifier<List<FundEntity>> {
  late final SubscribeToFund _subscribe;

  /// Construye el ViewModel e inicializa los datos de fondos desde el repositorio.
  @override
  Future<List<FundEntity>> build() async {
    final repo = ref.watch(fundsRepositoryProvider);

    _subscribe = ref.watch(subscribeUseCaseProvider);

    return repo.getFunds();
  }

  /// Suscribe al usuario a un fondo con los validaciones de negocio.
  /// 
  /// Parámetros:
  /// - [fund]: El fondo al que suscribirse.
  /// - [amount]: Monto a invertir en el fondo.
  /// 
  /// Retorna [Failure] si ocurre un error, null si es exitoso.
  Failure? subscribe(FundEntity fund, double amount) {
    final wallet = ref.read(walletProvider);
    final walletNotifier = ref.read(walletProvider.notifier);
    final txNotifier = ref.read(transactionsProvider.notifier);
    final subscriptionsNotifier = ref.read(subscriptionsProvider.notifier);

    try {
      _subscribe.execute(
        currentBalance: wallet,
        amount: amount,
        fundName: fund.name,
        minAmount: fund.minAmount,
        onSuccessSubtract: (value) {
          walletNotifier.subtract(value);
          subscriptionsNotifier.subscribe(fund.id, value);
        },
        onTransaction: (tx) => txNotifier.addTransaction(tx),
      );
      return null;
    } catch (e) {
      if (e is Failure) return e;

      return UnknownFailure();
    }
  }

  /// Cancela la suscripción a un fondo y reembolsa el monto invertido.
  /// 
  /// Parámetro [fund]: El fondo a cancelar.
  /// 
  /// Retorna [Failure] si ocurre un error, null si es exitoso.
  Failure? cancel(FundEntity fund) {
    final subscriptions = ref.read(subscriptionsProvider);
    final amount = subscriptions[fund.id] ?? 0;

    final walletNotifier = ref.read(walletProvider.notifier);
    final subscriptionsNotifier = ref.read(subscriptionsProvider.notifier);
    final txNotifier = ref.read(transactionsProvider.notifier);

    final useCase = ref.read(cancelSubscriptionProvider);

    try {
      useCase.execute(
        investedAmount: amount,
        fundName: fund.name,
        fundId: fund.id,
        onRefund: (value) => walletNotifier.add(value),
        onRemoveSubscription: () => subscriptionsNotifier.cancel(fund.id),
        onTransaction: (tx) => txNotifier.addTransaction(tx),
      );

      return null;
    } catch (e) {
      if (e is Failure) return e;

      return UnknownFailure();
    }
  }
}
