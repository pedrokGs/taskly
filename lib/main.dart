import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/core/dependencies_injector/riverpod.dart';
import 'package:taskly/features/home/presentation/screens/home_page.dart';

import 'features/theme/presentation/providers/theme_notifier.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: TasklyApp()),
  );
}

class TasklyApp extends ConsumerWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);

    return MaterialApp(
        title: 'Taskly',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeState.value,
        home: const HomePage(),
    );
  }
}
