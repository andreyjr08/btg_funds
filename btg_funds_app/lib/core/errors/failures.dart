/// Clase base abstracta para representar fallos en la aplicación.
/// Hereda de esta clase para definir tipos de fallos específicos.
/// El patrón "Failure" es parte de la arquitectura limpia para
/// diferenciar entre excepciones del sistema y fallos de negocio.
abstract class Failure {
  /// Mensaje descriptivo del fallo.
  /// Destinado a ser mostrado al usuario o registrado para debugging.
  final String message;

  /// Constructor que requiere un mensaje descriptivo del fallo.
  Failure(this.message);
}

/// Fallo cuando el saldo de la billetera es insuficiente.
/// Se dispara cuando se intenta invertir más dinero del disponible.
class InsufficientBalanceFailure extends Failure {
  /// Crea un fallo de saldo insuficiente con mensaje predefinido.
  InsufficientBalanceFailure() : super("Saldo insuficiente para la operación");
}

/// Fallo cuando el monto es menor al mínimo requerido por el fondo.
/// Cada fondo tiene un monto mínimo de inversión.
class MinimumAmountFailure extends Failure {
  /// Crea un fallo de monto mínimo con mensaje predefinido.
  MinimumAmountFailure() : super("El monto es menor al mínimo requerido");
}

/// Fallo cuando se intenta cancelar una suscripción inexistente.
/// El usuario no estaba suscrito al fondo especificado.
class NotSubscribedFailure extends Failure {
  /// Crea un fallo de no suscripción con mensaje predefinido.
  NotSubscribedFailure() : super("No estás suscrito a este fondo");
}

/// Fallo genérico para errores inesperados o no categorizados.
/// Se usa como fallback cuando no hay una categoría específica.
class UnknownFailure extends Failure {
  /// Crea un fallo desconocido con mensaje personalizado o default.
  /// 
  /// Parámetros:
  ///   - Mensaje personalizado (opcional, default: "Error inesperado").
  UnknownFailure([super.message = "Error inesperado"]);
}

/// Fallo de validación con mensaje personalizado.
/// Se usa para fallos de validación de datos de entrada.
class ValidationFailure extends Failure {
  /// Crea un fallo de validación con mensaje personalizado.
  /// 
  /// Parámetros:
  ///   - [message]: Descripción del error de validación.
  ValidationFailure(super.message);
}
