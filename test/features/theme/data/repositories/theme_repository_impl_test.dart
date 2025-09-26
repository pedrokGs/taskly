import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskly/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:taskly/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:taskly/features/theme/domain/entities/theme_entity.dart';
import 'package:taskly/features/theme/domain/repositories/theme_repository.dart';

class MockDatasource extends Mock implements ThemeLocalDatasource {}

void main() {
  late ThemeRepository repository;
  late MockDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockDatasource();
    repository = ThemeRepositoryImpl(themeLocalDatasource: mockDatasource);
  });

  test('getTheme should delegate to datasource', () async {
    final themeEntity = ThemeEntity(themeType: ThemeType.dark);
    when(() => mockDatasource.getTheme()).thenAnswer((_) async => themeEntity);

    final result = await repository.getTheme();

    expect(result, themeEntity);
    verify(() => mockDatasource.getTheme()).called(1);
  });

  test('saveTheme should delegate to datasource', () async {
    final themeEntity = ThemeEntity(themeType: ThemeType.light);
    when(() => mockDatasource.saveTheme(themeEntity))
        .thenAnswer((_) async => Future.value());

    await repository.saveTheme(themeEntity);

    verify(() => mockDatasource.saveTheme(themeEntity)).called(1);
  });
}
