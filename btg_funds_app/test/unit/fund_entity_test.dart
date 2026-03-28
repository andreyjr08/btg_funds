import 'package:flutter_test/flutter_test.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';

void main() {
  group('FundEntity', () {
    test('should create a FundEntity with correct properties', () {
      // Arrange
      const int id = 1;
      const String name = 'Fondo Acciones';
      const double minAmount = 1000.0;
      const String category = 'Acciones';

      // Act
      final fund = FundEntity(
        id: id,
        name: name,
        minAmount: minAmount,
        category: category,
      );

      // Assert
      expect(fund.id, equals(id));
      expect(fund.name, equals(name));
      expect(fund.minAmount, equals(minAmount));
      expect(fund.category, equals(category));
    });

    test('should support equality comparison', () {
      // Arrange
      final fund1 = FundEntity(
        id: 1,
        name: 'Fondo Acciones',
        minAmount: 1000.0,
        category: 'Acciones',
      );

      final fund2 = FundEntity(
        id: 1,
        name: 'Fondo Acciones',
        minAmount: 1000.0,
        category: 'Acciones',
      );

      final fund3 = FundEntity(
        id: 2,
        name: 'Fondo Renta Fija',
        minAmount: 500.0,
        category: 'Renta Fija',
      );

      // Assert
      expect(fund1.id, equals(fund2.id));
      expect(fund1.name, equals(fund2.name));
      expect(fund1.id, isNot(equals(fund3.id)));
    });

    test('should handle different categories correctly', () {
      // Arrange & Act
      final fundAcciones = FundEntity(
        id: 1,
        name: 'Fondo Acciones',
        minAmount: 1000.0,
        category: 'Acciones',
      );

      final fundRentaFija = FundEntity(
        id: 2,
        name: 'Fondo Renta Fija',
        minAmount: 500.0,
        category: 'Renta Fija',
      );

      final fundDiverso = FundEntity(
        id: 3,
        name: 'Fondo Diverso',
        minAmount: 750.0,
        category: 'Diversificado',
      );

      // Assert
      expect(fundAcciones.category, equals('Acciones'));
      expect(fundRentaFija.category, equals('Renta Fija'));
      expect(fundDiverso.category, equals('Diversificado'));
    });

    test('should handle zero and negative minimum amounts', () {
      // Arrange
      final fundZero = FundEntity(
        id: 1,
        name: 'Fondo Especial',
        minAmount: 0.0,
        category: 'Especial',
      );

      final fundNegative = FundEntity(
        id: 2,
        name: 'Fondo Test',
        minAmount: -100.0,
        category: 'Test',
      );

      // Assert
      expect(fundZero.minAmount, equals(0.0));
      expect(fundNegative.minAmount, equals(-100.0));
    });
  });
}
