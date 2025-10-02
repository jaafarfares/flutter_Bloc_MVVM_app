import 'package:equatable/equatable.dart';


import '../../models/user.dart';


abstract class AuthState extends Equatable {
@override
List<Object?> get props => [];
}


class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}


class AuthAuthenticated extends AuthState {
final User user;
AuthAuthenticated(this.user);


@override
List<Object?> get props => [user];
}


class AuthUnauthenticated extends AuthState {}


class AuthFailure extends AuthState {
final String message;
AuthFailure(this.message);


@override
List<Object?> get props => [message];
}