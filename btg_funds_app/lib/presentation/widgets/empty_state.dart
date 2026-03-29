import 'package:flutter/material.dart';

/// Widget que muestra un estado vacío.
/// Utilizado cuando no hay datos para mostrar en una lista o sección.
class EmptyState extends StatelessWidget {
  /// Mensaje a mostrar en el estado vacío.
  final String message;

  /// Crea un [EmptyState].
  /// 
  /// Parámetros:
  ///   - [message]: Texto a mostrar.
  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.grey)),
    );
  }
}
