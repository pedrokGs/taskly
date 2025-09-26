import 'package:taskly/features/theme/domain/entities/theme_entity.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';

class GetThemeUseCase{
  final ThemeRepository themeRepository;

  GetThemeUseCase({required this.themeRepository});

  Future<ThemeEntity> call() async {
    return await themeRepository.getTheme();
  }
}