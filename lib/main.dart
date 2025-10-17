import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/core/configs/router_config.dart';
import 'package:taskly/core/dependencies_injector/riverpod.dart';
import 'package:taskly/features/theme/presentation/providers/theme_notifier.dart';

import 'core/configs/firebase_options_dev.dart' as dev;
import 'core/configs/firebase_options_prod.dart' as prod;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isProd = bool.fromEnvironment("darm.vm.product");

  await Firebase.initializeApp(
    options: isProd
        ? prod.DefaultFirebaseOptions.currentPlatform
        : dev.DefaultFirebaseOptions.currentPlatform,
    name: "Taskly",
  );

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

    return MaterialApp.router(
      title: 'Taskly',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeState.value,
      routerConfig: AppRouter.router,
    );
  }
}
