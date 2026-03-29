import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/presentation/screens/my_app.dart';

/// Punto de entrada de la aplicación Flutter.
/// Inicializa la aplicación con Riverpod para la gestión del estado.
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
