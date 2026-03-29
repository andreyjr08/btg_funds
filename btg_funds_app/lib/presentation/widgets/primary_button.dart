import 'package:flutter/material.dart';

/// Widget que representa un botón elevado primario.
/// Utilizado como botón de acción principal en formularios.
class PrimaryButton extends StatelessWidget {
  /// Texto a mostrar en el botón.
  final String text;
  
  /// Callback ejecutado al presionar el botón.
  final VoidCallback? onPressed;

  /// Crea un [PrimaryButton].
  /// 
  /// Parámetros:
  ///   - [text]: Texto a mostrar.
  ///   - [onPressed]: Callback al presionar (opcional, desactiva si es null).
  const PrimaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
