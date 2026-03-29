import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/repositories/funds_repository.dart';
import 'package:btg_funds_app/data/repositories/funds_repository_impl.dart';
import 'package:btg_funds_app/data/datasources/mock_funds_data_source.dart';

/// Provider que proporciona la instancia de [MockFundsDataSource].
/// Fuente de datos simulada para fondos de inversión.
final fundsDataSourceProvider = Provider<MockFundsDataSource>((ref) {
  return MockFundsDataSource();
});

/// Provider que proporciona la implementación del repositorio de fondos.
/// Combina la fuente de datos con la interfaz [FundsRepository].
final fundsRepositoryProvider = Provider<FundsRepository>((ref) {
  final dataSource = ref.watch(fundsDataSourceProvider);
  return FundsRepositoryImpl(dataSource);
});
