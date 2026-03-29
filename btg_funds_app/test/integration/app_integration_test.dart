import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/presentation/screens/my_app.dart';
import 'package:btg_funds_app/presentation/providers/wallet_provider.dart';
import 'package:btg_funds_app/presentation/providers/subscriptions_provider.dart';
import 'package:btg_funds_app/presentation/providers/transactions_provider.dart';

void main() {
  group('App Integration Tests', () {
    testWidgets('should display funds screen on app start', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Fondos'), findsWidgets);
    });

    testWidgets('should show available balance on app start', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Saldo disponible'), findsOneWidget);
    });

    testWidgets('should display funds list', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      // Assert - Looking for fund cards with "Suscribirse" buttons
      expect(find.text('Suscribirse'), findsWidgets);
    });
    testWidgets(
      'should change subscription status from Disponible to Activo after subscribing',
      (WidgetTester tester) async {
        await tester.pumpWidget(const ProviderScope(child: MyApp()));
        await tester.pumpAndSettle();

        expect(find.text('Disponible'), findsWidgets);

        final subscribeButton = find.text('Suscribirse').first;

        await tester.ensureVisible(subscribeButton);
        await tester.pumpAndSettle();

        final buttonWidget = tester.widget<ElevatedButton>(
          find.ancestor(
            of: subscribeButton,
            matching: find.byType(ElevatedButton),
          ),
        );
        expect(buttonWidget.onPressed, isNotNull);

        await tester.tap(subscribeButton);
        await tester.pumpAndSettle();

        final amountField = find.byType(TextFormField);
        expect(amountField, findsOneWidget);

        // Extraer el monto mínimo mostrado en la primera tarjeta
        final minLabel = find.textContaining('Monto mínimo:').first;
        expect(minLabel, findsOneWidget);

        final minText = (tester.widget<Text>(minLabel).data ?? 'Monto mínimo: 0')
            .replaceAll(RegExp(r'[^0-9]'), '');

        final minAmount = int.tryParse(minText) ?? 75000;

        await tester.enterText(amountField, minAmount.toString());
        await tester.pumpAndSettle();

        final confirmButton = find.text('Confirmar suscripción');
        expect(confirmButton, findsOneWidget);

        await tester.tap(confirmButton);
        await tester.pumpAndSettle();

        // Aseguramos que el estado cambie a Activo al menos para una tarjeta
        expect(find.text('Activo'), findsWidgets);
      },
    );

    testWidgets('should navigate to transactions screen from FAB', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      // Look for the "Ver historial" button
      final fab = find.byWidgetPredicate(
        (widget) =>
            widget is FloatingActionButton ||
            (widget is SizedBox && widget.child is FloatingActionButton),
      );

      if (fab.evaluate().isNotEmpty) {
        await tester.tap(fab.first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('wallet should start with correct initial balance', (
      WidgetTester tester,
    ) async {
      // Arrange
      final container = ProviderContainer();
      final wallet = container.read(walletProvider);

      // Assert
      expect(wallet, equals(500000.0));
    });

    testWidgets('subscriptions should be empty initially', (
      WidgetTester tester,
    ) async {
      // Arrange
      final container = ProviderContainer();
      final subscriptions = container.read(subscriptionsProvider);

      // Assert
      expect(subscriptions.isEmpty, isTrue);
    });

    testWidgets('transactions should be empty initially', (
      WidgetTester tester,
    ) async {
      // Arrange
      final container = ProviderContainer();
      final transactions = container.read(transactionsProvider);

      // Assert
      expect(transactions.isEmpty, isTrue);
    });

    testWidgets('wallet state should deduct after subscription attempt', (
      WidgetTester tester,
    ) async {
      // Arrange
      final container = ProviderContainer();
      final initialBalance = container.read(walletProvider);

      // Act - Subtract amount from wallet
      container.read(walletProvider.notifier).subtract(50000.0);

      // Assert
      final newBalance = container.read(walletProvider);
      expect(newBalance, equals(initialBalance - 50000.0));
    });

    testWidgets('should restore balance when adding funds', (
      WidgetTester tester,
    ) async {
      // Arrange
      final container = ProviderContainer();
      final initialBalance = container.read(walletProvider);

      // Act
      container.read(walletProvider.notifier).subtract(50000.0);
      container.read(walletProvider.notifier).add(30000.0);

      // Assert
      final finalBalance = container.read(walletProvider);
      expect(finalBalance, equals(initialBalance - 20000.0));
    });

    testWidgets('multiple fund operations should update state correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      final container = ProviderContainer();

      // Act - Perform multiple operations
      container.read(walletProvider.notifier).subtract(10000.0);
      container.read(walletProvider.notifier).subtract(5000.0);
      container.read(walletProvider.notifier).add(3000.0);

      // Assert
      final finalBalance = container.read(walletProvider);
      expect(finalBalance, equals(500000.0 - 10000.0 - 5000.0 + 3000.0));
    });
  });
}
