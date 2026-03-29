import 'package:flutter/material.dart';

/// Widget que muestra un título de sección.
/// Utilizado en AppBar y otras secciones con texto destacado.
class SectionTitle extends StatelessWidget {
  /// Texto del título.
  final String text;

  /// Crea un [SectionTitle].
  /// 
  /// Parámetros:
  ///   - [text]: Texto a mostrar como título.
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
