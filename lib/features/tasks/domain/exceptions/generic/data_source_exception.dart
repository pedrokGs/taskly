class DataSourceException implements Exception{
  final String cause;
  final StackTrace? stack;
  DataSourceException({required this.cause, this.stack});
}