import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskly/common/screens/error_screen.dart';
import 'package:taskly/common/screens/loading_screen.dart';
import 'package:taskly/core/get_it/get_it.dart';
import 'package:taskly/features/theme/presentation/providers/theme_provider.dart';

import 'core/configs/firebase_options_dev.dart' as dev;
import 'core/configs/firebase_options_prod.dart' as prod;
import 'features/auth/presentation/screens/sign_in_screen.dart';
import 'features/auth/presentation/screens/sign_up_screen.dart';

final _router = GoRouter(
  initialLocation: '/signIn',
  // redirect
  routes: [
    GoRoute(
      path: '/error',
      builder: (context, state) {
        final errorMessage =
            state.uri.queryParameters['errorMessage'] ?? 'Erro desconhecido';
        return ErrorScreen(errorMessage: errorMessage);
      },
    ),
    GoRoute(path: '/loading', builder: (context, state) => LoadingScreen()),
    GoRoute(path: '/signIn', builder: (context, state) => SignInScreen()),
    GoRoute(path: '/signUp', builder: (context, state) => SignUpScreen()),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isProd = bool.fromEnvironment("darm.vm.product");

  await Firebase.initializeApp(
    options: isProd
        ? prod.DefaultFirebaseOptions.currentPlatform
        : dev.DefaultFirebaseOptions.currentPlatform,
    name: "Taskly",
  );

  await setupLocator();

  runApp(ProviderScope(child: TasklyApp()));
}

class TasklyApp extends ConsumerWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);

    return themeState.when(
      data: (themeMode) => MaterialApp.router(
        title: 'Taskly',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
        routerConfig: _router,
      ),
      loading: () =>
          MaterialApp.router(title: 'Taskly', routerConfig: _router),
      error: (error, stacktrace) =>
          MaterialApp.router(title: 'Taskly', routerConfig: _router),
    );
  }
}
