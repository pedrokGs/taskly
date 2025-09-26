import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:taskly/features/theme/domain/entities/theme_entity.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ThemeLocalDatasource datasource;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    datasource = ThemeLocalDatasource(sharedPreferences: mockPrefs);
  });

  test('should save ThemeEntity.light to SharedPreferences', () async {
    when(() => mockPrefs.setString('theme_key', 'light'))
        .thenAnswer((_) async => true);

    await datasource.saveTheme(ThemeEntity(themeType: ThemeType.light));

    verify(() => mockPrefs.setString('theme_key', 'light')).called(1);
  });

  test('should save ThemeEntity.dark to SharedPreferences', () async {
    when(() => mockPrefs.setString('theme_key', 'dark'))
        .thenAnswer((_) async => true);

    await datasource.saveTheme(ThemeEntity(themeType: ThemeType.dark));

    verify(() => mockPrefs.setString('theme_key', 'dark')).called(1);
  });

  test('should get ThemeEntity.dark from SharedPreferences', () async {
    when(() => mockPrefs.getString('theme_key')).thenReturn('dark');

    final result = await datasource.getTheme();

    expect(result.themeType, ThemeType.dark);
  });

  test('should get ThemeEntity.light from SharedPreferences', () async {
    when(() => mockPrefs.getString('theme_key')).thenReturn('light');

    final result = await datasource.getTheme();

    expect(result.themeType, ThemeType.light);
  });

  test('should return ThemeEntity.light if no value is stored', () async {
    when(() => mockPrefs.getString('theme_key')).thenReturn(null);

    final result = await datasource.getTheme();

    expect(result.themeType, ThemeType.light);
  });
}
