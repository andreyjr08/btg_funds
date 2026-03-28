import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/presentation/routes/routes.dart';
import 'package:btg_funds_app/presentation/widgets/subscribe_modal.dart';
import 'package:btg_funds_app/presentation/providers/wallet_provider.dart';
import 'package:btg_funds_app/presentation/providers/funds_view_model.dart';
import 'package:btg_funds_app/presentation/providers/subscriptions_provider.dart';

class FundsScreen extends ConsumerWidget {
  const FundsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundsAsync = ref.watch(fundsViewModelProvider);
    final balance = ref.watch(walletProvider);
    final subscriptions = ref.watch(subscriptionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Fondos")),
      body: fundsAsync.when(
        data: (funds) => ListView.builder(
          itemCount: funds.length,
          itemBuilder: (_, i) {
            final fund = funds[i];
            final isSubscribed = subscriptions.containsKey(fund.id);

            return ListTile(
              title: Text(fund.name),
              subtitle: Text("Min: ${fund.minAmount}"),
              trailing: ElevatedButton(
                onPressed: () {
                  if (isSubscribed) {
                    _confirmCancel(context, () {
                      final error = ref
                          .read(fundsViewModelProvider.notifier)
                          .cancel(fund);

                      if (error != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error)));
                      }
                    });
                  } else {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => SubscribeModal(fund: fund),
                    );
                  }
                },
                child: Text(isSubscribed ? "Cancelar" : "Suscribirse"),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 120,
        child: FloatingActionButton(
          onPressed: () {
            context.push(Routes.transactions);
          },
          child: const Text("Ver historial"),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Saldo: $balance"),
      ),
    );
  }

  void _confirmCancel(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar cancelación"),
        content: const Text("¿Estás seguro de que quieres cancelar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: const Text("Sí"),
          ),
        ],
      ),
    );
  }
}
