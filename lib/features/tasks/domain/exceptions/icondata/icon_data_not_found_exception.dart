class IconDataNotFoundException implements Exception{
  final String message;
  IconDataNotFoundException([this.message = "dados do ícone não encontrado."]);

  @override
  String toString() => 'IconDataNotFoundException: $message';
}