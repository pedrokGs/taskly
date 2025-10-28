import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/auth_providers.dart';
import 'package:taskly/features/auth/domain/exceptions/invalid_credentials_exception.dart';
import 'package:taskly/features/auth/domain/exceptions/sign_in_with_google_cancelled_exception.dart';
import 'package:taskly/features/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:taskly/features/auth/domain/exceptions/wrong_password_exception.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_with_google_use_case.dart';

class SignInState{
  final String? errorMessage;
  final bool isLoading;
  final bool success;

  SignInState({this.errorMessage, this.isLoading = false, this.success = false});
}

class SignInStateNotifier extends Notifier<SignInState>{
  late final SignInUseCase signInUseCase;
  late final SignInWithGoogleUseCase signInWithGoogleUseCase;

  @override
  SignInState build() {
    signInUseCase = ref.watch(signInUseCaseProvider);
    signInWithGoogleUseCase = ref.watch(signInWithGoogleUseCaseProvider);
    return SignInState();
  }

  Future<void> signIn(String email, String password) async {
    state = SignInState(isLoading: true);
    try{
      await signInUseCase.call(email: email, password: password);
      state = SignInState(isLoading: false, success: true);
    } on InvalidCredentialsException {
      state = SignInState(isLoading: false, errorMessage: "Credenciais inválidas, verifique a senha e o email");
    } on UserNotFoundException {
      state = SignInState(isLoading: false, errorMessage: "Usuário não encontrado");
    } on WrongPasswordException {
      state = SignInState(isLoading: false, errorMessage: "Verifique os campos novamente");
    } catch (e) {
      state = SignInState(isLoading: false, errorMessage: "Erro desconhecido: $e");
    }
  }

  Future<void> signInWithGoogle() async{
    state = SignInState(isLoading: true);
    try{
      await signInWithGoogleUseCase.call();
      state = SignInState(isLoading: false, success: true);
    } on InvalidCredentialsException{
      state = SignInState(isLoading: false, errorMessage: "Credenciais inválidas");
    } on SignInWithGoogleCancelledException{
      state = SignInState(isLoading: false, errorMessage: "A entrada foi cancelada");
    } catch(e){
      state = SignInState(isLoading: false, errorMessage: "Erro deconhecido: $e");
    }
  }
}