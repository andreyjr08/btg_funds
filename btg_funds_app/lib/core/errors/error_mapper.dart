import 'failures.dart';
import 'exceptions.dart';

/// Mapeador de excepciones a fallos de dominio.
/// Convierte excepciones del sistema en objetos Failure para usarlos
/// en la capa de dominio y presentación.
/// 
/// Patrón: Adaptor que traduce excepciones técnicas a fallos de negocio.
class ErrorMapper {
  /// Mapea una excepción a su correspondiente objeto [Failure].
  /// 
  /// Parámetros:
  ///   - [e]: Excepción a mapear.
  /// 
  /// Retorna: Objeto [Failure] correspondiente a la excepción.
  /// 
  /// Tipos de excepciones manejadas:
  ///   - [ServerException]: Retorna [UnknownFailure] con mensaje de servidor.
  ///   - Otras: Retorna [UnknownFailure] genérico.
  static Failure map(Exception e) {
    if (e is ServerException) {
      return UnknownFailure("Error del servidor");
    }

    return UnknownFailure();
  }
}
