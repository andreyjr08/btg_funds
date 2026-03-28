import 'failures.dart';
import 'exceptions.dart';

class ErrorMapper {
  static Failure map(Exception e) {
    if (e is ServerException) {
      return UnknownFailure("Error del servidor");
    }

    return UnknownFailure();
  }
}
