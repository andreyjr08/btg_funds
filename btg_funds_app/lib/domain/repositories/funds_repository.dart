import 'package:btg_funds_app/domain/entities/fund_entity.dart';

abstract class FundsRepository {
  Future<List<FundEntity>> getFunds();
}
