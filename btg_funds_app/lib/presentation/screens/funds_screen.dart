import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/presentation/providers/wallet_provider.dart';
import 'package:btg_funds_app/presentation/providers/funds_view_model.dart';

class FundsScreen extends ConsumerWidget {
  const FundsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundsAsync = ref.watch(fundsViewModelProvider);
    final balance = ref.watch(walletProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Fondos")),
      body: fundsAsync.when(
        data: (funds) => ListView.builder(
          itemCount: funds.length,
          itemBuilder: (_, i) {
            final fund = funds[i];

            return ListTile(
              title: Text(fund.name),
              subtitle: Text("Min: ${fund.minAmount}"),
              trailing: ElevatedButton(
                onPressed: () {
                  // abrir modal suscripción
                },
                child: const Text("Suscribirse"),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Saldo: $balance"),
      ),
    );
  }
}
