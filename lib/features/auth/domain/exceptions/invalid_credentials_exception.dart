import 'package:taskly/features/auth/domain/exceptions/auth_exception.dart';

class InvalidCredentialsException extends AuthException{
  InvalidCredentialsException() : super("Invalid credentials");

  @override
  String toString() {
    return "InvalidCredentialsException: $message";
  }
}