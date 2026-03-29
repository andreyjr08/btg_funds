import 'package:btg_funds_app/domain/entities/fund_entity.dart';

/// Fuente de datos simulada para fondos de inversión.
/// Proporciona datos mock sin necesidad de conectarse a una API real.
/// Útil para pruebas y desarrollo.
class MockFundsDataSource {
  /// Obtiene una lista simulada de fondos disponibles.
  /// 
  /// Simula una llamada asincrónica a una API con un retraso de 1 segundo.
  /// Retorna un Future que resuelve a una lista de [FundEntity] con datos predefinidos.
  /// 
  /// Retorna:
  ///   - [List<FundEntity>]: Lista de 5 fondos de inversión con nombres,
  ///     montos mínimos y categorías (FPV y FIC).
  /// 
  /// Lanza: Nunca lanza excepciones en versión mock.
  Future<List<FundEntity>> getFunds() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      FundEntity(
        id: 1,
        name: "FPV_BTG_PACTUAL_RECAUDADORA",
        minAmount: 75000,
        category: "FPV",
      ),
      FundEntity(
        id: 2,
        name: "FPV_BTG_PACTUAL_ECOPETROL",
        minAmount: 125000,
        category: "FPV",
      ),
      FundEntity(
        id: 3,
        name: "DEUDAPRIVADA",
        minAmount: 50000,
        category: "FIC",
      ),
      FundEntity(
        id: 4,
        name: "FDO-ACCIONES",
        minAmount: 250000,
        category: "FIC",
      ),
      FundEntity(
        id: 5,
        name: "FPV_BTG_PACTUAL_DINAMICA",
        minAmount: 100000,
        category: "FPV",
      ),
    ];
  }
}
