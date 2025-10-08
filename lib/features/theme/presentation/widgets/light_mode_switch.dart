import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';


class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      ),
      onPressed: () {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },
      tooltip: 'Alternar Tema',
    );
  }
}
