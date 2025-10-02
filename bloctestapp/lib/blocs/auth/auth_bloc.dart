import 'package:flutter_bloc/flutter_bloc.dart';


import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
final AuthRepository authRepository;


AuthBloc(this.authRepository) : super(AuthInitial()) {
on<AppStarted>((event, emit) async {
emit(AuthLoading());
try {
final hasToken = await authRepository.hasToken();
if (hasToken) {
final user = await authRepository.getUser();
if (user != null) {
emit(AuthAuthenticated(user));
} else {
emit(AuthUnauthenticated());
}
} else {
emit(AuthUnauthenticated());
}
} catch (e) {
emit(AuthFailure(e.toString()));
}
});


on<LoggedIn>((event, emit) async {
emit(AuthLoading());
await authRepository.persistToken(event.token, event.user);
emit(AuthAuthenticated(event.user));
});


on<LoggedOut>((event, emit) async {
emit(AuthLoading());
await authRepository.deleteToken();
emit(AuthUnauthenticated());
});
}
}