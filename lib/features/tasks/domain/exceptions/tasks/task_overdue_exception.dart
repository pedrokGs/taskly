class TaskOverdueException implements Exception{
  final String message;
  TaskOverdueException([this.message = "Task já passou do prazo"]);

  @override
  String toString() => 'TaskOverdueException: $message';
}