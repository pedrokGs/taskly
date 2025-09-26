class TaskCategoryNotFoundException implements Exception{
  final String message;
  TaskCategoryNotFoundException([this.message = "categoria de task não encontrada."]);

  @override
  String toString() => 'TaskCategoryNotFoundException: $message';
}