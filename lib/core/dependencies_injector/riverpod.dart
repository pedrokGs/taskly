import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:taskly/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';
import 'package:taskly/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:taskly/features/theme/domain/usecases/save_theme_use_case.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError(),); // Inicializado na main
final themeLocalDataSourceProvider = Provider<ThemeLocalDatasource>((ref) => ThemeLocalDatasource(sharedPreferences: ref.watch(sharedPreferencesProvider)),);
final themeRepositoryProvider = Provider<ThemeRepository>((ref) => ThemeRepositoryImpl(themeLocalDatasource: ref.watch(themeLocalDataSourceProvider)),);
final getThemeUseCaseProvider = Provider<GetThemeUseCase>((ref) => GetThemeUseCase(themeRepository: ref.watch(themeRepositoryProvider)),);
final saveThemeUseCaseProvider = Provider<SaveThemeUseCase>((ref) => SaveThemeUseCase(themeRepository: ref.watch(themeRepositoryProvider)),);