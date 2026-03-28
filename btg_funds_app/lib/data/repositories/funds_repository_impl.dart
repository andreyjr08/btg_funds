import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/domain/repositories/funds_repository.dart';
import 'package:btg_funds_app/data/datasources/mock_funds_data_source.dart';

class FundsRepositoryImpl implements FundsRepository {
  final MockFundsDataSource dataSource;

  FundsRepositoryImpl(this.dataSource);

  @override
  Future<List<FundEntity>> getFunds() {
    return dataSource.getFunds();
  }
}
