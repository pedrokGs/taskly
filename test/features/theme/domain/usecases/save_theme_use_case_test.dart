import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskly/features/theme/domain/entities/theme_entity.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';
import 'package:taskly/features/theme/domain/usecases/save_theme_use_case.dart';

// Mock do repository
class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  late SaveThemeUseCase useCase;
  late MockThemeRepository mockRepository;

  setUp(() {
    mockRepository = MockThemeRepository();
    useCase = SaveThemeUseCase(themeRepository: mockRepository);
  });

  test('should call repository to save theme', () async {
    // Arrange
    final themeEntity = ThemeEntity(themeType: ThemeType.light);
    when(() => mockRepository.saveTheme(themeEntity))
        .thenAnswer((_) async => Future.value());

    // Act
    await useCase(themeEntity);

    // Assert
    verify(() => mockRepository.saveTheme(themeEntity)).called(1);
  });
}
