import 'package:equatable/equatable.dart';


import '../../models/user.dart';


abstract class AuthEvent extends Equatable {
@override
List<Object?> get props => [];
}


class AppStarted extends AuthEvent {}


class LoggedIn extends AuthEvent {
final String token;
final User user;
LoggedIn({required this.token, required this.user});


@override
List<Object?> get props => [token, user];
}


class LoggedOut extends AuthEvent {}