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

/// Pantalla principal que muestra la lista de fondos disponibles.
/// Soporta layouts responsivos para diferentes tamaños de pantalla.
class FundsScreen extends ConsumerWidget {
  const FundsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundsAsync = ref.watch(fundsViewModelProvider);
    final balance = ref.watch(walletProvider);
    final subscriptions = ref.watch(subscriptionsProvider);

    return Scaffold(
      appBar: AppBar(title: const SectionTitle("Fondos")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return fundsAsync.when(
            data: (funds) => ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 12,
                vertical: 12,
              ),
              itemCount: funds.length,
              itemBuilder: (_, i) {
                final fund = funds[i];
                final isSubscribed = subscriptions.containsKey(fund.id);

                return Padding(
                  padding: EdgeInsets.only(bottom: isTablet ? 20 : 12),
                  child: FundCard(
                    fundEntity: fund,
                    isSubscribed: isSubscribed,
                    onAction: () {
                      if (isSubscribed) {
                        _confirmCancel(context, () {
                          final error = ref
                              .read(fundsViewModelProvider.notifier)
                              .cancel(fund);

                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.message)),
                            );
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
                                  bottom: MediaQuery.of(
                                    context,
                                  ).viewInsets.bottom,
                                ),
                                child: SubscribeModal(fund: fund),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: $e'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      bottomNavigationBar: _buildBalanceCard(balance),
    );
  }

  /// Construye el botón flotante de forma responsiva.
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.push(Routes.transactions);
      },
      icon: const Icon(Icons.history),
      label: const Text("Historial"),
    );
  }

  /// Construye la tarjeta de saldo de forma responsiva.
  Widget _buildBalanceCard(double balance) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.all(isMobile ? 12 : 20),
          child: AppCard(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 12 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Saldo disponible",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  MoneyText(amount: balance),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Muestra un diálogo de confirmación para cancelación de suscripciones.
  void _confirmCancel(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar cancelación"),
        content: const Text(
          "¿Estás seguro de que quieres cancelar esta suscripción?",
        ),
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
            child: const Text("Sí, cancelar"),
          ),
        ],
      ),
    );
  }
}
