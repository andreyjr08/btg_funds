import 'package:flutter_test/flutter_test.dart';
import 'package:btg_funds_app/core/errors/failures.dart';
import 'package:btg_funds_app/domain/usecases/subscribe_to_fund.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

void main() {
  group('SubscribeToFund UseCase', () {
    late SubscribeToFund subscribeToFund;

    setUp(() {
      subscribeToFund = SubscribeToFund();
    });

    test('should subtract amount from wallet on successful subscription', () {
      // Arrange
      double currentBalance = 100000.0;
      double amount = 10000.0;
      double minAmount = 5000.0;
      String fundName = 'Fondo Acciones';
      double amountSubtracted = 0;
      FundTransaction? recordedTransaction;

      // Act
      subscribeToFund.execute(
        currentBalance: currentBalance,
        amount: amount,
        fundName: fundName,
        minAmount: minAmount,
        onSuccessSubtract: (subtractAmount) {
          amountSubtracted = subtractAmount;
        },
        onTransaction: (transaction) {
          recordedTransaction = transaction;
        },
      );

      // Assert
      expect(amountSubtracted, equals(amount));
      expect(recordedTransaction, isNotNull);
      expect(recordedTransaction!.amount, equals(amount));
      expect(recordedTransaction!.fundName, equals(fundName));
      expect(recordedTransaction!.type, equals(TransactionType.subscribe));
    });

    test('should throw ValidationFailure when balance is insufficient', () {
      // Arrange
      double currentBalance = 5000.0;
      double amount = 10000.0;
      double minAmount = 1000.0;
      String fundName = 'Fondo Acciones';

      // Act & Assert
      expect(
        () => subscribeToFund.execute(
          currentBalance: currentBalance,
          amount: amount,
          fundName: fundName,
          minAmount: minAmount,
          onSuccessSubtract: (_) {},
          onTransaction: (_) {},
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('should throw ValidationFailure when amount is less than minimum', () {
      // Arrange
      double currentBalance = 100000.0;
      double amount = 2000.0;
      double minAmount = 5000.0;
      String fundName = 'Fondo Acciones';

      // Act & Assert
      expect(
        () => subscribeToFund.execute(
          currentBalance: currentBalance,
          amount: amount,
          fundName: fundName,
          minAmount: minAmount,
          onSuccessSubtract: (_) {},
          onTransaction: (_) {},
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('should create transaction with correct date', () {
      // Arrange
      double currentBalance = 100000.0;
      double amount = 10000.0;
      double minAmount = 5000.0;
      String fundName = 'Fondo Acciones';
      FundTransaction? recordedTransaction;
      final beforeExecution = DateTime.now();

      // Act
      subscribeToFund.execute(
        currentBalance: currentBalance,
        amount: amount,
        fundName: fundName,
        minAmount: minAmount,
        onSuccessSubtract: (_) {},
        onTransaction: (transaction) {
          recordedTransaction = transaction;
        },
      );
      final afterExecution = DateTime.now();

      // Assert
      expect(recordedTransaction, isNotNull);
      expect(
        recordedTransaction!.date.isAfter(beforeExecution.subtract(const Duration(seconds: 1))),
        isTrue,
      );
      expect(
        recordedTransaction!.date.isBefore(afterExecution.add(const Duration(seconds: 1))),
        isTrue,
      );
    });

    test('should allow subscription with amount equal to minimum', () {
      // Arrange
      double currentBalance = 100000.0;
      double amount = 5000.0;
      double minAmount = 5000.0;
      String fundName = 'Fondo Acciones';
      double amountSubtracted = 0;

      // Act
      subscribeToFund.execute(
        currentBalance: currentBalance,
        amount: amount,
        fundName: fundName,
        minAmount: minAmount,
        onSuccessSubtract: (subtractAmount) {
          amountSubtracted = subtractAmount;
        },
        onTransaction: (_) {},
      );

      // Assert
      expect(amountSubtracted, equals(amount));
    });

    test('should handle edge case with exact balance equal to amount', () {
      // Arrange
      double currentBalance = 10000.0;
      double amount = 10000.0;
      double minAmount = 5000.0;
      String fundName = 'Fondo Acciones';
      double amountSubtracted = 0;

      // Act
      subscribeToFund.execute(
        currentBalance: currentBalance,
        amount: amount,
        fundName: fundName,
        minAmount: minAmount,
        onSuccessSubtract: (subtractAmount) {
          amountSubtracted = subtractAmount;
        },
        onTransaction: (_) {},
      );

      // Assert
      expect(amountSubtracted, equals(amount));
    });

    test('should fail when balance is just below the required amount', () {
      // Arrange
      double currentBalance = 9999.99;
      double amount = 10000.0;
      double minAmount = 5000.0;
      String fundName = 'Fondo Acciones';

      // Act & Assert
      expect(
        () => subscribeToFund.execute(
          currentBalance: currentBalance,
          amount: amount,
          fundName: fundName,
          minAmount: minAmount,
          onSuccessSubtract: (_) {},
          onTransaction: (_) {},
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });
  });
}
