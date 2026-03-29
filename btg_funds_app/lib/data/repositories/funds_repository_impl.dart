import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/domain/repositories/funds_repository.dart';
import 'package:btg_funds_app/data/datasources/mock_funds_data_source.dart';

/// Implementación concrete del repositorio de fondos.
/// Actúa como intermediario entre la capa de datos (datasources) y la capa de dominio.
/// Encapsula la lógica de obtención de datos desde la fuente de datos.
class FundsRepositoryImpl implements FundsRepository {
  /// Fuente de datos simulada que proporciona la lista de fondos.
  final MockFundsDataSource dataSource;

  /// Constructor que inyecta la dependencia de [MockFundsDataSource].
  /// 
  /// Parámetros:
  ///   - [dataSource]: Instancia de la fuente de datos para acceder a los fondos.
  FundsRepositoryImpl(this.dataSource);

  /// Obtiene la lista de todos los fondos disponibles.
  /// 
  /// Retorna un Future que resuelve a una lista de [FundEntity].
  /// Invoca el método [getFunds] en la fuente de datos.
  @override
  Future<List<FundEntity>> getFunds() {
    return dataSource.getFunds();
  }
}
