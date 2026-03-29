import 'package:flutter/material.dart';

/// Widget tarjeta reutilizable con estilo Material.
/// Proporciona un contenedor con sombra y bordes redondeados.
class AppCard extends StatelessWidget {
  /// Widget hijo a contener dentro de la tarjeta.
  final Widget child;

  /// Crea un [AppCard].
  /// 
  /// Parámetros:
  ///   - [child]: Widget a mostrar dentro de la tarjeta.
  const AppCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}
