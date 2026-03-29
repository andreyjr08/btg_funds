/// Representa una entidad de fondo de inversión.
/// 
/// Contiene la información básica sobre un fondo disponible para suscripción,
/// incluidos identificador único, nombre, monto mínimo de inversión y categoría.
class FundEntity {
  /// Identificador único del fondo.
  final int id;

  /// Nombre descriptivo del fondo (ej: "Fondo Acciones BTG").
  final String name;

  /// Monto mínimo requerido para suscribirse al fondo.
  final double minAmount;

  /// Categoría de clasificación del fondo (ej: "Acciones", "Renta Fija").
  final String category;

  /// Crea una nueva instancia de [FundEntity].
  /// 
  /// Todos los parámetros son requeridos.
  FundEntity({
    required this.id,
    required this.name,
    required this.minAmount,
    required this.category,
  });
}
