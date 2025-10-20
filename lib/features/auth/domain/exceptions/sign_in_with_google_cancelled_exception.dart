import 'package:taskly/features/auth/domain/exceptions/auth_exception.dart';

class SignInWithGoogleCancelledException extends AuthException{
  SignInWithGoogleCancelledException() : super("User cancelled sign in with google");

  @override
  String toString() {
    return "SignInWithGoogleCancelledException: $message";
  }
}