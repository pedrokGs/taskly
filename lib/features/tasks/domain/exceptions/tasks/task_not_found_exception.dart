class TaskNotFoundException implements Exception{
  final String message;
  TaskNotFoundException([this.message = "Task não encontrada"]);

  @override
  String toString() => 'TaskNotFoundException: $message';
}