import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/tasks/data/datasource/task_category_remote_data_source_firebase.dart';
import 'package:taskly/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:taskly/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:taskly/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:taskly/features/theme/domain/usecases/save_theme_use_case.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';

var getIt = GetIt.instance;

Future<void> setupLocator() async{

  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Tasks
  getIt.registerSingleton<TaskCategoryRemoteDataSourceFirebase>(TaskCategoryRemoteDataSourceFirebase(firestore: getIt<FirebaseFirestore>()));

  // Themes
  getIt.registerSingleton<ThemeLocalDatasource>(ThemeLocalDatasource(sharedPreferences: getIt<SharedPreferences>()));

  getIt.registerSingleton<ThemeRepositoryImpl>(ThemeRepositoryImpl(themeLocalDatasource: getIt<ThemeLocalDatasource>()));

  getIt.registerSingleton<GetThemeUseCase>(GetThemeUseCase(themeRepository: getIt<ThemeRepositoryImpl>()));
  getIt.registerSingleton<SaveThemeUseCase>(SaveThemeUseCase(themeRepository: getIt<ThemeRepositoryImpl>()));

  getIt.registerFactory<ThemeNotifier>(() => ThemeNotifier(getThemeUseCase: getIt<GetThemeUseCase>(), saveThemeUseCase: getIt<SaveThemeUseCase>()),);
}