import 'package:taskly/features/auth/domain/exceptions/auth_exception.dart';

class UserNotFoundException extends AuthException{
  UserNotFoundException() : super("User not found");

  @override
  String toString() {
    return "UserNotFoundException: $message";
  }
}