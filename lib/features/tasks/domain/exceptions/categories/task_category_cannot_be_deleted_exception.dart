class TaskCategoryCannotBeDeletedException implements Exception{
  final String message;
  TaskCategoryCannotBeDeletedException([this.message = "Categoria não pode ser deletada (padrão ou possui tasks existentes)"]);

  @override
  String toString() => 'TaskCategoryCannotBeDeletedException: $message';
}