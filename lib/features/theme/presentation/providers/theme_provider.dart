import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/get_it/get_it.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';

final themeNotifierProvider = AsyncNotifierProvider<ThemeNotifier, ThemeMode>(
      () => getIt<ThemeNotifier>(),
);