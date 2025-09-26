class InvalidIconDataException implements Exception{
  final String message;
  InvalidIconDataException([this.message = "dados do ícone estão em formato inválido."]);

  @override
  String toString() => 'InvalidIconDataException: $message';
}