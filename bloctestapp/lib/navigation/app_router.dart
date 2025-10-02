import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/splash_screen.dart';
/* 
class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (state) {
      final authState = authBloc.state;
      final loggingIn = state.subloc == '/login';

      if (authState is AuthAuthenticated && loggingIn) return '/home';
      if (authState is! AuthAuthenticated && !loggingIn) return '/login';
      return null; // no redirect
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          final user = (authBloc.state as AuthAuthenticated).user;
          return HomeScreen(user: user);
        },
      ),
    ],
  );
}
 */