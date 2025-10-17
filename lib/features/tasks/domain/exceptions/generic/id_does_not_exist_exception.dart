class IdDoesNotExistException implements Exception{
  final String cause;
  final StackTrace? stack;
  IdDoesNotExistException({required this.cause, this.stack});
}