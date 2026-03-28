import 'package:btg_funds_app/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/presentation/widgets/app_card.dart';
import 'package:btg_funds_app/presentation/widgets/status_chip.dart';
import 'package:btg_funds_app/presentation/widgets/primary_button.dart';

class FundCard extends StatelessWidget {
  final FundEntity fundEntity;
  final bool isSubscribed;
  final VoidCallback onAction;

  const FundCard({
    super.key,
    required this.fundEntity,
    required this.isSubscribed,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(fundEntity.name),
                StatusChip(
                  label: isSubscribed ? "Activo" : "Disponible",
                  color: isSubscribed ? Colors.green : Colors.grey,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monto mínimo: ${CurrencyFormatter.format(fundEntity.minAmount)}",
                ),
                Text("Categoría: ${fundEntity.category}"),
              ],
            ),

            PrimaryButton(
              text: isSubscribed ? "Cancelar" : "Suscribirse",
              onPressed: onAction,
            ),
          ],
        ),
      ),
    );
  }
}
