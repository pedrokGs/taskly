import 'package:go_router/go_router.dart';
import 'package:taskly/features/auth/presentation/screens/password_reset_screen.dart';

import '../../common/screens/error_screen.dart';
import '../../common/screens/loading_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
class AppRouter{
  static final GoRouter router = GoRouter(
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
      GoRoute(path: '/resetPassword', builder: (context, state) => PasswordResetScreen(),),
    ],
  );
}