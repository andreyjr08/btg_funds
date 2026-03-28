import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper functions for testing

/// Crea un ProviderContainer para testing
ProviderContainer createTestContainer() {
  return ProviderContainer();
}

/// Crea una entidad de fondo para testing
FundEntity createTestFund({
  int id = 1,
  String name = 'Test Fund',
  double minAmount = 1000.0,
  String category = 'Test',
}) {
  return FundEntity(
    id: id,
    name: name,
    minAmount: minAmount,
    category: category,
  );
}

/// Lista de fondos de ejemplo para testing
List<FundEntity> createTestFunds() {
  return [
    FundEntity(
      id: 1,
      name: 'Fondo Acciones',
      minAmount: 5000.0,
      category: 'Acciones',
    ),
    FundEntity(
      id: 2,
      name: 'Fondo Renta Fija',
      minAmount: 1000.0,
      category: 'Renta Fija',
    ),
    FundEntity(
      id: 3,
      name: 'Fondo Diverso',
      minAmount: 2500.0,
      category: 'Diversificado',
    ),
  ];
}

/// Wrapper para renderizar widgets en tests
class TestApp extends StatelessWidget {
  final Widget child;
  final ProviderContainer? providerContainer;

  const TestApp({
    super.key,
    required this.child,
    this.providerContainer,
  });

  @override
  Widget build(BuildContext context) {
    if (providerContainer != null) {
      return UncontrolledProviderScope(
        container: providerContainer!,
        child: MaterialApp(
          home: Scaffold(body: child),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(body: child),
    );
  }
}

/// Crea un MaterialApp para testing de widgets
MaterialApp createTestMaterialApp({
  required Widget child,
}) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

/// Verifica si un widget existe en el tree
bool widgetExists(WidgetTester tester, Type widgetType) {
  return find.byType(widgetType).evaluate().isNotEmpty;
}

/// Encuentra y tappea el widget con el texto especificado
Future<void> tapButtonWithText(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

/// Encuentra y ingresa texto en un TextField
Future<void> enterTextInField(
  WidgetTester tester,
  String text, {
  int index = 0,
}) async {
  final textFields = find.byType(TextField);
  if (textFields.evaluate().isNotEmpty) {
    await tester.enterText(textFields.at(index), text);
    await tester.pumpAndSettle();
  }
}

/// Verifica si existe un widget con el tipo especificado
bool containsWidgetOfType(WidgetTester tester, Type widgetType) {
  return find.byType(widgetType).evaluate().isNotEmpty;
}

/// Espera a que el widget desaparezca
Future<void> waitForWidgetToDisappear(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  await tester.pumpAndSettle(timeout);
  expect(finder, findsNothing);
}

/// Espera a que el widget aparezca
Future<void> waitForWidgetToAppear(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  await tester.pumpAndSettle(timeout);
  expect(finder, findsOneWidget);
}

/// Extrae el texto de un widget Text
String? getTextValue(WidgetTester tester, Type widgetType) {
  final finder = find.byType(widgetType);
  if (finder.evaluate().isNotEmpty) {
    final widget = finder.evaluate().first.widget as Text;
    return widget.data;
  }
  return null;
}

/// Verifica que la lista de widgets se renderice correctamente
void verifyListOfWidgets(
  WidgetTester tester,
  Type widgetType,
  int expectedCount,
) {
  expect(find.byType(widgetType), findsNWidgets(expectedCount));
}
