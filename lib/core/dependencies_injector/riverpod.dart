import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource_firebase.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:taskly/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:taskly/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';
import 'package:taskly/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:taskly/features/theme/domain/usecases/save_theme_use_case.dart';

// Auth
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn.instance);
final authRemoteDataSourceProvider = Provider((ref) => AuthRemoteDataSourceFirebase(firebaseAuth: ref.watch(firebaseAuthProvider), googleSignIn: ref.watch(googleSignInProvider)),);
final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(remoteDataSource: ref.watch(authRemoteDataSourceProvider)),);
final signInUseCaseProvider = Provider((ref) => SignInUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final signUpUseCaseProvider = Provider((ref) => SignUpUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final signOutUseCaseProvider = Provider((ref) => SignOutUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final signInWithGoogleUseCaseProvider = Provider((ref) => SignInWithGoogleUseCase(authRepository: ref.watch(authRepositoryProvider)),);
final authUserProvider = StreamProvider<AuthUserEntity?>((ref) => ref.watch(authRepositoryProvider).authUser);

// Theme
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError(),); // Inicializado na main
final themeLocalDataSourceProvider = Provider<ThemeLocalDatasource>((ref) => ThemeLocalDatasource(sharedPreferences: ref.watch(sharedPreferencesProvider)),);
final themeRepositoryProvider = Provider<ThemeRepository>((ref) => ThemeRepositoryImpl(themeLocalDatasource: ref.watch(themeLocalDataSourceProvider)),);
final getThemeUseCaseProvider = Provider<GetThemeUseCase>((ref) => GetThemeUseCase(themeRepository: ref.watch(themeRepositoryProvider)),);
final saveThemeUseCaseProvider = Provider<SaveThemeUseCase>((ref) => SaveThemeUseCase(themeRepository: ref.watch(themeRepositoryProvider)),);