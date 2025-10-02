import 'package:bloctestapp/blocs/auth/auth_state.dart';
import 'package:bloctestapp/ui/screens/auth/login_screen.dart';
import 'package:bloctestapp/ui/screens/auth/splash_screen.dart';
import 'package:bloctestapp/ui/screens/home/home_schomereen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM + BLoC Sample',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading || state is AuthInitial) {
            return const SplashScreen();
          } else if (state is AuthAuthenticated) {
            return HomeScreen(user: state.user);
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
