/// Excepción para errores del servidor remoto.
/// Se dispara cuando la API retorna un error (5xx o similar).
class ServerException implements Exception {}

/// Excepción para errores de caché.
/// Se dispara cuando hay un problema accediendo o escribiendo en el caché local.
class CacheException implements Exception {}
