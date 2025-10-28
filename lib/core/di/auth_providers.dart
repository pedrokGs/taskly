import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource_firebase.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskly/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:taskly/features/auth/presentation/state/password_reset_state.dart';
import 'package:taskly/features/auth/presentation/state/sign_in_state.dart';
import 'package:taskly/features/auth/presentation/state/sign_up_state.dart';

// Data
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn.instance);
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) => AuthRemoteDataSourceFirebase(firebaseAuth: ref.watch(firebaseAuthProvider), googleSignIn: ref.watch(googleSignInProvider)),);
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl(remoteDataSource: ref.watch(authRemoteDataSourceProvider)),);
final authUserProvider = StreamProvider<AuthUserEntity?>((ref) => ref.watch(authRepositoryProvider).authUser);

// Use Cases
final signInUseCaseProvider = Provider<SignInUseCase>((ref) => SignInUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) => SignUpUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) => SignOutUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((ref) => SignInWithGoogleUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) => ResetPasswordUseCase(authRepository: ref.watch(authRepositoryProvider)),);

// Presentation
final signInNotifierProvider = NotifierProvider<SignInStateNotifier, SignInState>(() => SignInStateNotifier(),);
final signUpNotifierProvider = NotifierProvider<SignUpStateNotifier, SignUpState>(() => SignUpStateNotifier(),);
final passwordResetNotifierProvider = NotifierProvider<PasswordResetStateNotifier, PasswordResetState>(() => PasswordResetStateNotifier(),);