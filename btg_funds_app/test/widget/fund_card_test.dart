import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/presentation/widgets/fund_card.dart';

void main() {
  group('FundCard Widget', () {
    final fundEntity = FundEntity(
      id: 1,
      name: 'Fondo Acciones',
      minAmount: 5000.0,
      category: 'Acciones',
    );

    testWidgets('should display fund name', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Fondo Acciones'), findsOneWidget);
    });

    testWidgets('should display minimum amount formatted', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('Monto mínimo:'), findsOneWidget);
    });

    testWidgets('should display fund category', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Categoría: Acciones'), findsOneWidget);
    });

    testWidgets('should show "Disponible" chip when not subscribed',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Disponible'), findsOneWidget);
    });

    testWidgets('should show "Activo" chip when subscribed', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: true,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Activo'), findsOneWidget);
    });

    testWidgets('should show "Suscribirse" button when not subscribed',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Suscribirse'), findsOneWidget);
    });

    testWidgets('should show "Cancelar" button when subscribed',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: true,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Cancelar'), findsOneWidget);
    });

    testWidgets('should call onAction when button is pressed', (WidgetTester tester) async {
      // Arrange
      bool wasCalled = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {
                wasCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Suscribirse'));
      await tester.pumpAndSettle();

      // Assert
      expect(wasCalled, isTrue);
    });

    testWidgets('should display different funds correctly', (WidgetTester tester) async {
      // Arrange
      final funds = [
        FundEntity(id: 1, name: 'Fondo A', minAmount: 1000, category: 'Acciones'),
        FundEntity(id: 2, name: 'Fondo B', minAmount: 5000, category: 'Renta Fija'),
        FundEntity(id: 3, name: 'Fondo C', minAmount: 2500, category: 'Mixto'),
      ];

      for (final fund in funds) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FundCard(
                fundEntity: fund,
                isSubscribed: false,
                onAction: () {},
              ),
            ),
          ),
        );

        expect(find.text(fund.name), findsOneWidget);
        expect(find.text('Categoría: ${fund.category}'), findsOneWidget);
      }
    });

    testWidgets('should update correctly when isSubscribed changes',
        (WidgetTester tester) async {
      // Act - First render as not subscribed
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.text('Disponible'), findsOneWidget);
      expect(find.text('Suscribirse'), findsOneWidget);

      // Rebuild with isSubscribed = true
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: true,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Activo'), findsOneWidget);
      expect(find.text('Cancelar'), findsOneWidget);
    });

    testWidgets('should handle multiple action callbacks', (WidgetTester tester) async {
      // Arrange
      int actionCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundEntity,
              isSubscribed: false,
              onAction: () {
                actionCount++;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Suscribirse'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Suscribirse'));
      await tester.pumpAndSettle();

      // Assert
      expect(actionCount, equals(2));
    });

    testWidgets('should render with large fund names', (WidgetTester tester) async {
      // Arrange
      final fundWithLongName = FundEntity(
        id: 1,
        name: 'Fondo de Inversión en Acciones Internacionales de Largo Plazo',
        minAmount: 5000,
        category: 'Acciones Internacionales',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FundCard(
              fundEntity: fundWithLongName,
              isSubscribed: false,
              onAction: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('Fondo de Inversión'), findsOneWidget);
    });
  });
}
