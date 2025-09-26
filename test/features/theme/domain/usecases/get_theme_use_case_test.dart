import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskly/features/theme/domain/entities/theme_entity.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';
import 'package:taskly/features/theme/domain/usecases/get_theme_use_case.dart';

// Mock do repository
class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  late GetThemeUseCase useCase;
  late MockThemeRepository mockRepository;

  setUp(() {
    mockRepository = MockThemeRepository();
    useCase = GetThemeUseCase(themeRepository: mockRepository);
  });

  test('should return ThemeEntity from repository', () async {
    // Arrange
    final themeEntity = ThemeEntity(themeType: ThemeType.dark);
    when(() => mockRepository.getTheme()).thenAnswer((_) async => themeEntity);

    // Act
    final result = await useCase();

    // Assert
    expect(result, themeEntity);
    verify(() => mockRepository.getTheme()).called(1);
  });
}
