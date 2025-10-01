import 'package:taskly/features/auth/domain/exceptions/auth_exception.dart';

class InvalidEmailException extends AuthException{
  InvalidEmailException() : super("Invalid email");

  @override
  String toString() {
    return "InvalidEmailException: $message";
  }
}