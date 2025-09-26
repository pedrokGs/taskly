import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:taskly/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';
import 'package:taskly/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:taskly/features/theme/domain/usecases/save_theme_use_case.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';

var getIt = GetIt.instance;

Future<void> init() async{
  getIt.registerSingleton(await SharedPreferences.getInstance());

  getIt.registerSingleton(ThemeLocalDatasource(sharedPreferences: getIt()));

  getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(themeLocalDatasource: getIt()));

  getIt.registerSingleton(GetThemeUseCase(themeRepository: getIt()));
  getIt.registerSingleton(SaveThemeUseCase(themeRepository: getIt()));

  getIt.registerFactory(() => ThemeNotifier(getThemeUseCase: getIt(), saveThemeUseCase: getIt()),);
}