import 'package:taskly/features/auth/domain/exceptions/auth_exception.dart';

class LogoutException extends AuthException{
  LogoutException() : super("Error on logging out");

  @override
  String toString() {
    return "LogoutException: $message";
  }
}