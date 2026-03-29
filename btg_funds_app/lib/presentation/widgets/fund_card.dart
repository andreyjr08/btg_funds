import 'package:btg_funds_app/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/presentation/widgets/app_card.dart';
import 'package:btg_funds_app/presentation/widgets/status_chip.dart';
import 'package:btg_funds_app/presentation/widgets/primary_button.dart';

/// Widget que muestra la información de un fondo de inversión.
/// Incluye nombre, monto mínimo, categoría y estado de suscripción.
class FundCard extends StatelessWidget {
  /// Entidad del fondo a mostrar.
  final FundEntity fundEntity;
  
  /// Indica si el usuario está suscrito a este fondo.
  final bool isSubscribed;
  
  /// Callback ejecutado al presionar el botón de acción.
  final VoidCallback onAction;

  /// Crea un [FundCard].
  /// 
  /// Parámetros:
  ///   - [fundEntity]: Fondo a mostrar.
  ///   - [isSubscribed]: Estado de suscripción.
  ///   - [onAction]: Callback para suscripción o cancelación.
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
                Expanded(child: Text(fundEntity.name)),
                StatusChip(
                  label: isSubscribed ? "Activo" : "Disponible",
                  color: isSubscribed ? Colors.green : Colors.grey,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Monto mínimo: ${CurrencyFormatter.format(fundEntity.minAmount)}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Categoría: ${fundEntity.category}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
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
