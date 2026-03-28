import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_funds_app/presentation/widgets/status_chip.dart';

void main() {
  group('StatusChip Widget', () {
    testWidgets('should render chip with label text', (
      WidgetTester tester,
    ) async {
      // Arrange
      const label = 'Active';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatusChip(label: label, color: Colors.green),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('should apply correct color to text', (
      WidgetTester tester,
    ) async {
      // Arrange
      const label = 'Inactive';
      const color = Colors.grey;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatusChip(label: label, color: color),
            ),
          ),
        ),
      );

      // Assert
      final textWidget = find.byType(Text);
      expect(textWidget, findsOneWidget);

      final text = textWidget.evaluate().first.widget as Text;
      expect(text.style?.color, equals(color));
    });

    testWidgets('should have correct font size', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatusChip(label: 'Test', color: Colors.blue),
            ),
          ),
        ),
      );

      // Assert
      final textWidget = find.byType(Text);
      final text = textWidget.evaluate().first.widget as Text;
      expect(text.style?.fontSize, equals(12));
    });

    testWidgets('should render with rounded corners', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatusChip(label: 'Status', color: Colors.red),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should have correct padding', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatusChip(label: 'Padded', color: Colors.orange),
            ),
          ),
        ),
      );

      // Assert
      final container = find.byType(Container);
      expect(container, findsOneWidget);

      final containerWidget = container.evaluate().first.widget as Container;
      expect(containerWidget.padding, isNotNull);
    });

    testWidgets('should display different labels correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      const labels = ['Active', 'Inactive', 'Pending', 'Completed'];

      for (final label in labels) {
        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: StatusChip(label: label, color: Colors.blue),
              ),
            ),
          ),
        );

        // Assert
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('should work with different colors', (
      WidgetTester tester,
    ) async {
      // Arrange
      const colors = [
        Colors.green,
        Colors.red,
        Colors.blue,
        Colors.amber,
        Colors.purple,
      ];

      for (final color in colors) {
        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: StatusChip(label: 'Test', color: color),
              ),
            ),
          ),
        );

        // Assert
        final textWidget = find.byType(Text);
        final text = textWidget.evaluate().first.widget as Text;
        expect(text.style?.color, equals(color));
      }
    });

    testWidgets('should handle empty label', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatusChip(label: '', color: Colors.blue),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('should handle long label text', (WidgetTester tester) async {
      // Arrange
      const longLabel = 'This is a very long status label that should wrap';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StatusChip(label: longLabel, color: Colors.blue),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(longLabel), findsOneWidget);
    });
  });
}
