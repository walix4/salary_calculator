/// Base failure type for domain/data error mapping.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
