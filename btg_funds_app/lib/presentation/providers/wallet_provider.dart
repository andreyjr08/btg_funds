import 'package:flutter_riverpod/legacy.dart';

final walletProvider = StateNotifierProvider<WalletNotifier, double>(
  (ref) => WalletNotifier(),
);

class WalletNotifier extends StateNotifier<double> {
  WalletNotifier() : super(500000);

  void subtract(double amount) {
    state -= amount;
  }

  void add(double amount) {
    state += amount;
  }
}
