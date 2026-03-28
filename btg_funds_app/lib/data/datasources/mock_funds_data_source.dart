import 'package:btg_funds_app/domain/entities/fund_entity.dart';

class MockFundsDataSource {
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
