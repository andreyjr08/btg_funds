import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/repositories/funds_repository.dart';
import 'package:btg_funds_app/data/repositories/funds_repository_impl.dart';
import 'package:btg_funds_app/data/datasources/mock_funds_data_source.dart';

final fundsDataSourceProvider = Provider<MockFundsDataSource>((ref) {
  return MockFundsDataSource();
});

final fundsRepositoryProvider = Provider<FundsRepository>((ref) {
  final dataSource = ref.watch(fundsDataSourceProvider);
  return FundsRepositoryImpl(dataSource);
});
