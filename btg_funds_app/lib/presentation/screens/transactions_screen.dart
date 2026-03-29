import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/presentation/widgets/money_text.dart';
import 'package:btg_funds_app/presentation/widgets/empty_state.dart';
import 'package:btg_funds_app/presentation/widgets/status_chip.dart';
import 'package:btg_funds_app/presentation/widgets/section_title.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';
import 'package:btg_funds_app/presentation/providers/transactions_provider.dart';

/// Filtros disponibles para las transacciones.
/// Permite filtrar entre todas, solo suscripciones o solo cancelaciones.
enum TransactionFilter { all, subscribe, cancel }

/// Pantalla que muestra el historial de transacciones del usuario.
/// Permite filtrar transacciones por tipo (suscripción/cancelación).
/// Las transacciones se muestran ordenadas por fecha (más recientes primero).
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
      return Scaffold(
        appBar: AppBar(title: const SectionTitle("Historial")),
        body: const EmptyState(message: "No tienes transacciones aún"),
      );
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
      appBar: AppBar(title: const SectionTitle("Historial")),
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

/// Widget que representa un elemento de transacción en la lista.
/// Muestra información resumida: tipo, fondo, fecha y monto de la transacción.
class _TransactionItem extends StatelessWidget {
  /// Transacción a mostrar.
  final FundTransaction tx;

  /// Crea un [_TransactionItem].
  /// 
  /// Parámetros:
  ///   - [tx]: Transacción a mostrar.
  const _TransactionItem({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isSubscribed = tx.type == TransactionType.subscribe;

    return ListTile(
      leading: StatusChip(
        label: isSubscribed ? "Activo" : "Disponible",
        color: isSubscribed ? Colors.green : Colors.grey,
      ),
      title: Text("Fondo ${tx.fundName}"),
      subtitle: Text(_formatDate(tx.date)),
      trailing: MoneyText(amount: tx.amount),
    );
  }

  /// Formatea una fecha al formato: dd/mm/yyyy hh:mm
  /// 
  /// Parámetros:
  ///   - [date]: Fecha y hora a formatear.
  /// 
  /// Retorna: String con la fecha formateada.
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} "
        "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
