import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/core/configs/router_config.dart';
import 'package:taskly/core/dependencies_injector/riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/theme/presentation/providers/theme_notifier.dart';

import 'core/configs/firebase_options_dev.dart' as dev;
import 'core/configs/firebase_options_prod.dart' as prod;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: '.env');

  bool isProd = bool.fromEnvironment("darm.vm.product");

  final serverClientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID'];
  await GoogleSignIn.instance.initialize(serverClientId: serverClientId);

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
      theme: AppTheme.getTheme(false),
      darkTheme: AppTheme.getTheme(true),
      themeMode: themeState.value,
      routerConfig: AppRouter.router,
    );
  }
}
