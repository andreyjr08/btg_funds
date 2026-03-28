import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/presentation/routes/routes.dart';
import 'package:btg_funds_app/presentation/widgets/app_card.dart';
import 'package:btg_funds_app/presentation/widgets/fund_card.dart';
import 'package:btg_funds_app/presentation/widgets/money_text.dart';
import 'package:btg_funds_app/presentation/widgets/section_title.dart';
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
      appBar: AppBar(title: const SectionTitle("Fondos")),
      body: fundsAsync.when(
        data: (funds) => ListView.builder(
          itemCount: funds.length,
          itemBuilder: (_, i) {
            final fund = funds[i];
            final isSubscribed = subscriptions.containsKey(fund.id);

            return FundCard(
              fundEntity: fund,
              isSubscribed: isSubscribed,
              onAction: () {
                if (isSubscribed) {
                  _confirmCancel(context, () {
                    final error = ref
                        .read(fundsViewModelProvider.notifier)
                        .cancel(fund);

                    if (error != null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error.message)));
                    }
                  });
                } else {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Wrap(children: [SubscribeModal(fund: fund)]),
                        ),
                      );
                    },
                  );
                }
              },
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
        child: AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Saldo disponible",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  MoneyText(amount: balance),
                ],
              ),
            ),
          ),
        ),
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
