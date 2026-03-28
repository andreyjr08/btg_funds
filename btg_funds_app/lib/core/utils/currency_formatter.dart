import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(
    double amount, {
    String locale = 'es_CO',
    String symbol = '\$',
    int decimals = 0,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimals,
    );

    return formatter.format(amount);
  }
}
