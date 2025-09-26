import 'package:taskly/features/theme/domain/entities/theme_entity.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';

class SaveThemeUseCase{
  final ThemeRepository themeRepository;

  SaveThemeUseCase({required this.themeRepository});

  Future call (ThemeEntity themeEntity) async{
    await themeRepository.saveTheme(themeEntity);
  }
}