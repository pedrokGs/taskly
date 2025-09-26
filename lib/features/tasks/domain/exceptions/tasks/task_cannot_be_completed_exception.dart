class TaskCannotBeCompletedException implements Exception{
  final String message;
  TaskCannotBeCompletedException([this.message = "Task não pode ser concluída (ex: task semanal que ainda não é o dia certo)"]);

  @override
  String toString() => 'TaskCannotBeCompletedException: $message';
}