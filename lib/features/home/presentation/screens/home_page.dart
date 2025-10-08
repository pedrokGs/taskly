import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';
import '../../../theme/presentation/widgets/light_mode_switch.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly Home'),
        actions: const [
          ThemeToggleButton()
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tema atual: ${themeMode == ThemeMode.light ? "Claro" : "Escuro"}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(themeNotifierProvider.notifier).toggleTheme();
              },
              child: const Text('Alternar Tema'),
            ),
          ],
        ),
      ),
    );
  }
}
