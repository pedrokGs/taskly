import 'package:taskly/features/auth/domain/exceptions/auth_exception.dart';

class WrongPasswordException extends AuthException{
  WrongPasswordException() : super("Wrong password");

  @override
  String toString() {
    return "WrongPasswordException: $message";
  }
}