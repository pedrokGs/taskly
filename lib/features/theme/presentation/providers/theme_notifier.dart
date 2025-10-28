import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/theme_providers.dart';

import '../../domain/entities/theme_entity.dart';
import '../../domain/usecases/get_theme_use_case.dart';
import '../../domain/usecases/save_theme_use_case.dart';

final themeNotifierProvider = AsyncNotifierProvider<ThemeNotifier, ThemeMode>(() => ThemeNotifier(),);

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  late final GetThemeUseCase getThemeUseCase;
  late final SaveThemeUseCase saveThemeUseCase;

  @override
  Future<ThemeMode> build() async {
    getThemeUseCase = ref.watch(getThemeUseCaseProvider);
    saveThemeUseCase = ref.watch(saveThemeUseCaseProvider);

    final themeEntity = await getThemeUseCase();
    return _mapEntityToThemeMode(themeEntity);
  }

  ThemeMode _mapEntityToThemeMode(ThemeEntity themeEntity) {
    return themeEntity.themeType == ThemeType.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final newTheme = state.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = AsyncData(newTheme);

    final themeType = newTheme == ThemeMode.light ? ThemeType.light : ThemeType.dark;
    await saveThemeUseCase(ThemeEntity(themeType: themeType));
  }
}
