class InvalidTaskException implements Exception{
  final String message;
  InvalidTaskException([this.message = "Task está em formato inválido."]);

  @override
  String toString() => 'InvalidTaskException: $message';
}