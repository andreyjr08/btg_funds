import 'package:btg_funds_app/domain/entities/fund_entity.dart';

/// Contrato (interfaz) para el repositorio de fondos de inversi\u00f3n.
/// Define el contrato que cualquier implementaci\u00f3n debe cumplir.
/// Abstracts la fuente de datos, permitiendo m\u00faltiples implementaciones
/// (mock, real HTTP, cache, etc.).
abstract class FundsRepository {
  /// Obtiene la lista de todos los fondos disponibles.
  /// 
  /// Retorna un Future que resuelve a una lista de [FundEntity].
  /// Las implementaciones pueden obtener estos datos de diferentes fuentes:
  /// - API REST real
  /// - Datos mock para pruebas
  /// - Base de datos local en cach\u00e9
  Future<List<FundEntity>> getFunds();
}
