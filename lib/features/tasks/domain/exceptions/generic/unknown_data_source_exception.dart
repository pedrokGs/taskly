class UnknownDataSourceException implements Exception{
  final String cause;
  final StackTrace? stack;
  UnknownDataSourceException({required this.cause, this.stack});
}