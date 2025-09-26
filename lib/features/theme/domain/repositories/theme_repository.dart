import 'package:taskly/features/theme/domain/entities/theme_entity.dart';

abstract class ThemeRepository{
  Future<ThemeEntity> getTheme();
  Future saveTheme(ThemeEntity theme);
}