import 'package:flutter_test/flutter_test.dart';
import 'package:btg_funds_app/presentation/providers/wallet_provider.dart';

void main() {
  group('WalletNotifier', () {
    test('should initialize with 500000.0 as default balance', () {
      // Arrange & Act
      final walletNotifier = WalletNotifier();

      // Assert
      expect(walletNotifier.state, equals(500000.0));
    });

    test('should subtract amount from current balance', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      final initialBalance = walletNotifier.state;
      final amountToSubtract = 50000.0;

      // Act
      walletNotifier.subtract(amountToSubtract);

      // Assert
      expect(
        walletNotifier.state,
        equals(initialBalance - amountToSubtract),
      );
    });

    test('should add amount to current balance', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      walletNotifier.subtract(100000.0); // Reduce balance first
      final balanceAfterSubtract = walletNotifier.state;
      final amountToAdd = 50000.0;

      // Act
      walletNotifier.add(amountToAdd);

      // Assert
      expect(
        walletNotifier.state,
        equals(balanceAfterSubtract + amountToAdd),
      );
    });

    test('should handle multiple subtractions', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      final initialBalance = walletNotifier.state;

      // Act
      walletNotifier.subtract(10000.0);
      walletNotifier.subtract(20000.0);
      walletNotifier.subtract(15000.0);

      // Assert
      expect(
        walletNotifier.state,
        equals(initialBalance - 45000.0),
      );
    });

    test('should handle multiple additions', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      final initialBalance = walletNotifier.state;

      // Act
      walletNotifier.add(10000.0);
      walletNotifier.add(20000.0);
      walletNotifier.add(5000.0);

      // Assert
      expect(
        walletNotifier.state,
        equals(initialBalance + 35000.0),
      );
    });

    test('should handle mixed operations (add and subtract)', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      final initialBalance = walletNotifier.state;

      // Act
      walletNotifier.subtract(30000.0);
      walletNotifier.add(10000.0);
      walletNotifier.subtract(5000.0);
      walletNotifier.add(20000.0);

      // Assert
      expect(
        walletNotifier.state,
        equals(initialBalance - 5000.0),
      ); // -30000 + 10000 - 5000 + 20000 = -5000
    });

    test('should allow balance to go negative', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      final currentBalance = walletNotifier.state;

      // Act
      walletNotifier.subtract(currentBalance + 100000.0);

      // Assert
      expect(walletNotifier.state, isNegative);
    });

    test('should handle zero amount operations', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      final initialBalance = walletNotifier.state;

      // Act
      walletNotifier.subtract(0.0);
      walletNotifier.add(0.0);

      // Assert
      expect(walletNotifier.state, equals(initialBalance));
    });

    test('should handle decimal amounts correctly', () {
      // Arrange
      final walletNotifier = WalletNotifier();
      final initialBalance = walletNotifier.state;

      // Act
      walletNotifier.subtract(1234.56);
      walletNotifier.add(567.89);

      // Assert
      expect(
        walletNotifier.state,
        closeTo(initialBalance - 666.67, 0.01),
      );
    });

    test('should maintain precision with floating point operations', () {
      // Arrange
      final walletNotifier = WalletNotifier();

      // Act - Perform operations that might cause floating point errors
      for (int i = 0; i < 100; i++) {
        walletNotifier.subtract(1.0);
      }
      for (int i = 0; i < 100; i++) {
        walletNotifier.add(1.0);
      }

      // Assert
      expect(walletNotifier.state, equals(500000.0));
    });
  });
}
