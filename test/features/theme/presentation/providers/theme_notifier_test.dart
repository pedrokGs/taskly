import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/features/theme/domain/entities/theme_entity.dart';
import 'package:taskly/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:taskly/features/theme/domain/usecases/save_theme_use_case.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';
import 'package:taskly/features/theme/presentation/providers/theme_provider.dart';

class MockGetThemeUseCase extends Mock implements GetThemeUseCase {}
class MockSaveThemeUseCase extends Mock implements SaveThemeUseCase {}

class FakeThemeEntity extends Fake implements ThemeEntity {}

void main() {
  late MockGetThemeUseCase mockGet;
  late MockSaveThemeUseCase mockSave;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(FakeThemeEntity());
  });


  setUp(() {
    mockGet = MockGetThemeUseCase();
    mockSave = MockSaveThemeUseCase();

    container = ProviderContainer(
      overrides: [
        themeNotifierProvider.overrideWith(
              () => ThemeNotifier(getThemeUseCase: mockGet, saveThemeUseCase: mockSave),
        ),
      ],
    );
  });

  test('should load initial theme from getThemeUseCase', () async {
    when(() => mockGet()).thenAnswer((_) async => ThemeEntity(themeType: ThemeType.dark));

    final notifier = container.read(themeNotifierProvider.notifier);
    await notifier.build();

    final themeMode = container.read(themeNotifierProvider).value;
    expect(themeMode, ThemeMode.dark);
  });

  test('should toggle theme', () async {
    when(() => mockGet()).thenAnswer((_) async => ThemeEntity(themeType: ThemeType.light));
    when(() => mockSave(any())).thenAnswer((_) async => {});

    final notifier = container.read(themeNotifierProvider.notifier);
    await notifier.build();
    await notifier.toggleTheme();

    final themeMode = container.read(themeNotifierProvider).value;
    expect(themeMode, ThemeMode.dark);

    verify(() => mockSave(any())).called(1);
  });
}
