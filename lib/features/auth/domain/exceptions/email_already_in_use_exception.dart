import 'package:taskly/features/auth/domain/exceptions/auth_exception.dart';

class EmailAlreadyInUseException extends AuthException{
  EmailAlreadyInUseException() : super("Email already in use");

  @override
  String toString() {
    return "EmailAlreadyInUseException: $message";
  }
}