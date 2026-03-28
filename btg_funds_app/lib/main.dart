import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/presentation/screens/my_app.dart';

/// Entry point of the Flutter application.
/// Initializes the app with Riverpod for state management.
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
