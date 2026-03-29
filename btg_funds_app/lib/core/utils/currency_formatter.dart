import 'package:intl/intl.dart';

/// Utilidad para formatear valores monet\u00e1rios.
/// Proporciona m\u00e9todos est\u00e1ticos para convertir n\u00fameros en formato moneda
/// con lokalizaci\u00f3n, s\u00edmbolos y decimales personalizables.
class CurrencyFormatter {
  /// Formatea un valor monet\u00e1rio con configuraci\u00f3n personalizable.
  /// 
  /// Par\u00e1metros:
  ///   - [amount]: El valor a formatear.
  ///   - [locale]: Locale para determinaci\u00f3n de formato (default: 'es_CO' - Colombia).
  ///   - [symbol]: S\u00edmbolo de moneda a usar (default: '\$').
  ///   - [decimals]: N\u00famero de decimales a mostrar (default: 0).
  /// 
  /// Retorna: String con el valor formateado (ej: "\$1.000.000").
  /// 
  /// Ejemplo:
  ///   CurrencyFormatter.format(150000) -> "\$150.000"
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
