import 'package:taskly/features/theme/domain/entities/theme_entity.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';
import '../datasource/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository{
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<ThemeEntity> getTheme() async {
    return await themeLocalDatasource.getTheme();
  }

  @override
  Future<void> saveTheme(ThemeEntity theme) async {
    return await themeLocalDatasource.saveTheme(theme);
  }

}