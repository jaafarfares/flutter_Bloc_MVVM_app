import 'package:flutter_bloc/flutter_bloc.dart';


import '../../repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
final AuthRepository authRepository;


LoginBloc({required this.authRepository}) : super(LoginInitial()) {
on<LoginSubmitted>((event, emit) async {
emit(LoginLoading());
try {
final res = await authRepository.login(event.email, event.password);
final token = res['token'] as String;
final user = res['user'];
emit(LoginSuccess(token: token, user: user));
} catch (e) {
emit(LoginFailure(e.toString()));
}
});
}
}