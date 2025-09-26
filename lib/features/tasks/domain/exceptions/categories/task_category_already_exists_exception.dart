class TaskCategoryAlreadyExistsException implements Exception{
  final String message;
  TaskCategoryAlreadyExistsException([this.message = "Categoria já existe."]);

  @override
  String toString() => 'TaskCategoryAlreadyExistsException: $message';
}