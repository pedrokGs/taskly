import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource_firebase.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:taskly/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:taskly/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:taskly/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';
import 'package:taskly/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:taskly/features/theme/domain/usecases/save_theme_use_case.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';

var getIt = GetIt.instance;

Future<void> setupLocator() async{
  getIt.registerSingleton(await SharedPreferences.getInstance());

  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  getIt.registerSingleton<AuthRemoteDataSourceFirebase>(AuthRemoteDataSourceFirebase(firebaseAuth: getIt<FirebaseAuth>()));
  getIt.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSourceFirebase>()));

  getIt.registerSingleton(ThemeLocalDatasource(sharedPreferences: getIt()));

  getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(themeLocalDatasource: getIt()));

  // Use cases
  // Themes
  getIt.registerSingleton(GetThemeUseCase(themeRepository: getIt()));
  getIt.registerSingleton(SaveThemeUseCase(themeRepository: getIt()));

  // Auth
  getIt.registerSingleton<SignInUseCase>(SignInUseCase(authRepository: getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<SignUpUseCase>(SignUpUseCase(authRepository: getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<SignOutUseCase>(SignOutUseCase(authRepository: getIt<AuthRepositoryImpl>()));

  getIt.registerFactory(() => ThemeNotifier(getThemeUseCase: getIt(), saveThemeUseCase: getIt()),);
}