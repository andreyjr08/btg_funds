import 'package:flutter_riverpod/legacy.dart';

final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, Map<int, double>>(
      (ref) => SubscriptionsNotifier(),
    );

class SubscriptionsNotifier extends StateNotifier<Map<int, double>> {
  SubscriptionsNotifier() : super({});

  void subscribe(int fundId, double amount) {
    state = {...state, fundId: (state[fundId] ?? 0) + amount};
  }

  void cancel(int fundId) {
    final newState = {...state};
    newState.remove(fundId);
    state = newState;
  }
}
