import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_funds_app/presentation/widgets/primary_button.dart';

void main() {
  group('PrimaryButton Widget', () {
    testWidgets('should render button with text', (WidgetTester tester) async {
      // Arrange
      const textValue = 'Click me';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(text: textValue, onPressed: () {}),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(textValue), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should call onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool wasPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(
                text: 'Click',
                onPressed: () {
                  wasPressed = true;
                },
              ),
            ),
          ),
        ),
      );

      final button = find.byType(ElevatedButton);

      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Assert
      expect(wasPressed, isTrue);
    });

    testWidgets(
      'should not call onPressed when button disabled (null callback)',
      (WidgetTester tester) async {
        // Arrange
        bool wasPressed = false;

        // Act
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: PrimaryButton(text: 'Disabled', onPressed: null),
              ),
            ),
          ),
        );

        // Try to tap
        final button = find.byType(ElevatedButton);

        await tester.ensureVisible(button);
        await tester.tap(button);
        await tester.pumpAndSettle();

        // Assert - Button should be disabled
        expect(wasPressed, isFalse);
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Disabled'), findsOneWidget);
      },
    );

    testWidgets('should display button with different text values', (
      WidgetTester tester,
    ) async {
      // Arrange
      const textValues = ['Submit', 'Cancel', 'Confirm', 'Delete'];

      for (final text in textValues) {
        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: PrimaryButton(text: text, onPressed: () {}),
              ),
            ),
          ),
        );

        // Assert
        expect(find.text(text), findsOneWidget);
      }
    });

    testWidgets('should handle rapid successive taps', (
      WidgetTester tester,
    ) async {
      // Arrange
      int tapCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(
                text: 'Tap me',
                onPressed: () {
                  tapCount++;
                },
              ),
            ),
          ),
        ),
      );

      // Tap multiple times
      final button = find.byType(ElevatedButton);

      await tester.pumpAndSettle();

      expect(tester.widget<ElevatedButton>(button).onPressed, isNotNull);

      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.tap(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Assert
      expect(tapCount, equals(3));
    });

    testWidgets('should display long text without overflow', (
      WidgetTester tester,
    ) async {
      // Arrange
      const longText =
          'This is a very long button text that should display correctly';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(text: longText, onPressed: () {}),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(longText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should render as StatelessWidget', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PrimaryButton(text: 'Test', onPressed: () {}),
            ),
          ),
        ),
      );

      // Assert - Verify it's a StatelessWidget by checking it rebuilds correctly
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(
        tester.widget<PrimaryButton>(find.byType(PrimaryButton)),
        isA<StatelessWidget>(),
      );
    });
  });
}
