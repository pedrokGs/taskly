import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/get_it/get_it.dart';
import 'package:taskly/features/home/presentation/screens/home_page.dart';
import 'package:taskly/features/theme/presentation/providers/theme_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    ProviderScope(child: TasklyApp()),
  );
}

class TasklyApp extends ConsumerWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);

    return themeState.when(
      data: (themeMode) => MaterialApp(
        title: 'Taskly',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
        home: const HomePage(),
      ),
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, st) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Erro ao carregar tema')),
        ),
      ),
    );
  }
}
