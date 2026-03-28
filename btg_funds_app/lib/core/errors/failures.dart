abstract class Failure {
  final String message;

  Failure(this.message);
}

class InsufficientBalanceFailure extends Failure {
  InsufficientBalanceFailure() : super("Saldo insuficiente para la operación");
}

class MinimumAmountFailure extends Failure {
  MinimumAmountFailure() : super("El monto es menor al mínimo requerido");
}

class NotSubscribedFailure extends Failure {
  NotSubscribedFailure() : super("No estás suscrito a este fondo");
}

class UnknownFailure extends Failure {
  UnknownFailure([super.message = "Error inesperado"]);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}
