import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';
import 'package:btg_funds_app/presentation/providers/transactions_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

enum TransactionFilter { all, subscribe, cancel }

class TransactionsScreen extends ConsumerWidget {
  final transactionFilterProvider = StateProvider<TransactionFilter>(
    (ref) => TransactionFilter.all,
  );

  TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);

    final sorted = [...transactions]..sort((a, b) => b.date.compareTo(a.date));

    if (sorted.isEmpty) {
      return const _EmptyState();
    }

    final filter = ref.watch(transactionFilterProvider);

    final filtered = sorted.where((tx) {
      if (filter == TransactionFilter.subscribe) {
        return tx.type == TransactionType.subscribe;
      }
      if (filter == TransactionFilter.cancel) {
        return tx.type == TransactionType.cancel;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text("Todos"),
                selected: filter == TransactionFilter.all,
                onSelected: (_) =>
                    ref.read(transactionFilterProvider.notifier).state =
                        TransactionFilter.all,
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text("Suscripciones"),
                selected: filter == TransactionFilter.subscribe,
                onSelected: (_) =>
                    ref.read(transactionFilterProvider.notifier).state =
                        TransactionFilter.subscribe,
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text("Cancelaciones"),
                selected: filter == TransactionFilter.cancel,
                onSelected: (_) =>
                    ref.read(transactionFilterProvider.notifier).state =
                        TransactionFilter.cancel,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, index) {
                final tx = filtered[index];
                return _TransactionItem(tx: tx);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final FundTransaction tx;

  const _TransactionItem({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isSubscribe = tx.type == TransactionType.subscribe;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isSubscribe
            ? Colors.green.withValues(alpha: 0.2)
            : Colors.red.withValues(alpha: 0.2),
        child: Icon(
          isSubscribe ? Icons.arrow_downward : Icons.arrow_upward,
          color: isSubscribe ? Colors.green : Colors.red,
        ),
      ),
      title: Text("Fondo ${tx.fundId}"),
      subtitle: Text(_formatDate(tx.date)),
      trailing: Text(
        "${isSubscribe ? '-' : '+'} \$${tx.amount.toStringAsFixed(2)}",
        style: TextStyle(
          color: isSubscribe ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} "
        "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: const Center(
        child: Text(
          "No tienes transacciones aún",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
