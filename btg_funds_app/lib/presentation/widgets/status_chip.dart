import 'package:flutter/material.dart';

/// Widget que muestra un chip (etiqueta) con estado visual.
/// Utilizado para mostrar el estado de un fondo (Activo/Disponible).
class StatusChip extends StatelessWidget {
  /// Texto a mostrar en el chip.
  final String label;
  
  /// Color base del chip.
  final Color color;

  /// Crea un [StatusChip].
  /// 
  /// Parámetros:
  ///   - [label]: Texto a mostrar.
  ///   - [color]: Color del chip.
  const StatusChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12)),
    );
  }
}
