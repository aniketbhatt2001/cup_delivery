class Success {
  final Map body;

  Success(
    this.body,
  );
}

class Failure {
  final String status;
  final String message;

  Failure(this.message, this.status);
}
