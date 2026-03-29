import 'package:btg_funds_app/domain/usecases/cancel_subscription.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/usecases/subscribe_to_fund.dart';

/// Provider que proporciona la instancia del usecase [SubscribeToFund].
/// Utilizado por los ViewModels para acceder a la lógica de suscripción.
final subscribeUseCaseProvider = Provider<SubscribeToFund>((ref) {
  return SubscribeToFund();
});

/// Provider que proporciona la instancia del usecase [CancelSubscription].
/// Utilizado por los ViewModels para acceder a la lógica de cancelación.
final cancelSubscriptionProvider = Provider<CancelSubscription>((ref) {
  return CancelSubscription();
});
