import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/dependencies_injector/riverpod.dart';
import 'package:taskly/features/auth/domain/exceptions/invalid_credentials_exception.dart';
import 'package:taskly/features/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:taskly/features/auth/domain/exceptions/wrong_password_exception.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_use_case.dart';

class SignInState{
  final String? errorMessage;
  final bool isLoading;
  final bool success;

  SignInState({this.errorMessage, this.isLoading = false, this.success = false});
}

class SignInStateNotifier extends Notifier<SignInState>{
  late final SignInUseCase signInUseCase;

  @override
  SignInState build() {
    signInUseCase = ref.watch(signInUseCaseProvider);
    return SignInState();
  }

  Future<void> signIn(String email, String password) async {
    state = SignInState(isLoading: true);
    try{
      await signInUseCase.call(email: email, password: password);
      state = SignInState(isLoading: false, success: true);
    } on InvalidCredentialsException {
      state = SignInState(isLoading: false, errorMessage: "Credenciais inválidas");
    } on UserNotFoundException {
      state = SignInState(isLoading: false, errorMessage: "Usuário não encontrado");
    } on WrongPasswordException {
      state = SignInState(isLoading: false, errorMessage: "Verifique os campos novamente");
    } catch (e) {
      state = SignInState(isLoading: false, errorMessage: "Erro desconhecido: $e");
    }
  }
}

final signInNotifierProvider = NotifierProvider<SignInStateNotifier, SignInState>(() => SignInStateNotifier(),);