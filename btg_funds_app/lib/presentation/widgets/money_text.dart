import 'package:flutter/material.dart';
import 'package:btg_funds_app/core/utils/currency_formatter.dart';

class MoneyText extends StatelessWidget {
  final double amount;

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
