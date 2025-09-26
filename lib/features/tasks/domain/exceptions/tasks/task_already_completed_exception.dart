class TaskAlreadyCompletedException implements Exception{
  final String message;
  TaskAlreadyCompletedException([this.message = "Task já foi concluída"]);

  @override
  String toString() => 'TaskAlreadyCompletedException: $message';
}