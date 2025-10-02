import 'package:bloctestapp/blocs/auth/auth_bloc.dart';
import 'package:bloctestapp/blocs/auth/auth_event.dart';
import 'package:bloctestapp/blocs/login/login_bloc.dart';
import 'package:bloctestapp/blocs/login/login_event.dart';
import 'package:bloctestapp/blocs/login/login_state.dart';
import 'package:bloctestapp/ui/widgets/custom_text_field.dart';
import 'package:bloctestapp/ui/widgets/loading_button.dart';
import 'package:bloctestapp/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            LoginBloc(authRepository: RepositoryProvider.of(context)),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Notify the AuthBloc that user has logged in
              context.read<AuthBloc>().add(
                    LoggedIn(token: state.token, user: state.user),
                  );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      key: Key("emailKey"),
                      controller: _emailCtrl,
                      labelText: 'Email',
                      validator: Validators.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      key: Key("passwordKey"),
                      controller: _passwordCtrl,
                      labelText: 'Password',
                      validator: Validators.required,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        final isLoading = state is LoginLoading;
                        return LoadingButton(
                          key: Key("loginKey"),
                          text: 'Login',
                          isLoading: isLoading,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<LoginBloc>().add(
                                    LoginSubmitted(
                                      email: _emailCtrl.text.trim(),
                                      password: _passwordCtrl.text.trim(),
                                    ),
                                  );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text('Tip: password = "password"'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
