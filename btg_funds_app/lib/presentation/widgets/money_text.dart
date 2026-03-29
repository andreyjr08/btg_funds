import 'package:flutter/material.dart';
import 'package:btg_funds_app/core/utils/currency_formatter.dart';

/// Widget que muestra una cantidad de dinero formateada.
/// Aplica color verde para montos positivos y rojo para negativos.
class MoneyText extends StatelessWidget {
  /// Cantidad monetaria a mostrar.
  final double amount;

  /// Crea un [MoneyText].
  /// 
  /// Parámetros:
  ///   - [amount]: Valor monetario a mostrar.
  const MoneyText({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final isNegative = amount < 0;
    final color = isNegative ? Colors.red : Colors.green;

    return Text(
      "${isNegative ? '-' : '+'} ${CurrencyFormatter.format(amount)}",
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
