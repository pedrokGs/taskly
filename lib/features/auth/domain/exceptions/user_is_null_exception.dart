class UserIsNullException implements Exception{
  final String errorMessage;
  UserIsNullException(this.errorMessage);

  @override
  String toString() {
    return 'UserIsNullException: $errorMessage';
  }
}