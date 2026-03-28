import 'package:flutter_test/flutter_test.dart';
import 'package:btg_funds_app/core/errors/failures.dart';
import 'package:btg_funds_app/domain/usecases/cancel_subscription.dart';
import 'package:btg_funds_app/domain/entities/fund_transaction_entity.dart';

void main() {
  group('CancelSubscription UseCase', () {
    late CancelSubscription cancelSubscription;

    setUp(() {
      cancelSubscription = CancelSubscription();
    });

    test('should refund amount and remove subscription on successful cancellation', () {
      // Arrange
      double investedAmount = 10000.0;
      String fundName = 'Fondo Acciones';
      int fundId = 1;
      double refundedAmount = 0;
      bool subscriptionRemoved = false;
      FundTransaction? recordedTransaction;

      // Act
      cancelSubscription.execute(
        investedAmount: investedAmount,
        fundName: fundName,
        fundId: fundId,
        onRefund: (amount) {
          refundedAmount = amount;
        },
        onRemoveSubscription: () {
          subscriptionRemoved = true;
        },
        onTransaction: (transaction) {
          recordedTransaction = transaction;
        },
      );

      // Assert
      expect(refundedAmount, equals(investedAmount));
      expect(subscriptionRemoved, isTrue);
      expect(recordedTransaction, isNotNull);
      expect(recordedTransaction!.amount, equals(investedAmount));
      expect(recordedTransaction!.fundName, equals(fundName));
      expect(recordedTransaction!.type, equals(TransactionType.cancel));
      expect(recordedTransaction!.fundId, equals(fundId));
    });

    test('should throw ValidationFailure when amount is zero', () {
      // Arrange
      double investedAmount = 0.0;
      String fundName = 'Fondo Acciones';
      int fundId = 1;

      // Act & Assert
      expect(
        () => cancelSubscription.execute(
          investedAmount: investedAmount,
          fundName: fundName,
          fundId: fundId,
          onRefund: (_) {},
          onRemoveSubscription: () {},
          onTransaction: (_) {},
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('should throw ValidationFailure when amount is negative', () {
      // Arrange
      double investedAmount = -5000.0;
      String fundName = 'Fondo Acciones';
      int fundId = 1;

      // Act & Assert
      expect(
        () => cancelSubscription.execute(
          investedAmount: investedAmount,
          fundName: fundName,
          fundId: fundId,
          onRefund: (_) {},
          onRemoveSubscription: () {},
          onTransaction: (_) {},
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('should execute callbacks in correct order', () {
      // Arrange
      double investedAmount = 10000.0;
      String fundName = 'Fondo Acciones';
      int fundId = 1;
      List<String> executionOrder = [];

      // Act
      cancelSubscription.execute(
        investedAmount: investedAmount,
        fundName: fundName,
        fundId: fundId,
        onRefund: (_) {
          executionOrder.add('refund');
        },
        onRemoveSubscription: () {
          executionOrder.add('remove');
        },
        onTransaction: (_) {
          executionOrder.add('transaction');
        },
      );

      // Assert
      expect(executionOrder, equals(['refund', 'remove', 'transaction']));
    });

    test('should handle large invested amounts', () {
      // Arrange
      double investedAmount = 1000000.0;
      String fundName = 'Fondo Premium';
      int fundId = 5;
      double refundedAmount = 0;

      // Act
      cancelSubscription.execute(
        investedAmount: investedAmount,
        fundName: fundName,
        fundId: fundId,
        onRefund: (amount) {
          refundedAmount = amount;
        },
        onRemoveSubscription: () {},
        onTransaction: (_) {},
      );

      // Assert
      expect(refundedAmount, equals(investedAmount));
    });

    test('should create transaction with correct fundId', () {
      // Arrange
      double investedAmount = 5000.0;
      String fundName = 'Fondo Renta Fija';
      int fundId = 42;
      FundTransaction? recordedTransaction;

      // Act
      cancelSubscription.execute(
        investedAmount: investedAmount,
        fundName: fundName,
        fundId: fundId,
        onRefund: (_) {},
        onRemoveSubscription: () {},
        onTransaction: (transaction) {
          recordedTransaction = transaction;
        },
      );

      // Assert
      expect(recordedTransaction!.fundId, equals(fundId));
    });

    test('should handle very small positive amounts', () {
      // Arrange
      double investedAmount = 0.01;
      String fundName = 'Fondo Test';
      int fundId = 1;
      double refundedAmount = 0;

      // Act
      cancelSubscription.execute(
        investedAmount: investedAmount,
        fundName: fundName,
        fundId: fundId,
        onRefund: (amount) {
          refundedAmount = amount;
        },
        onRemoveSubscription: () {},
        onTransaction: (_) {},
      );

      // Assert
      expect(refundedAmount, equals(investedAmount));
    });
  });
}
