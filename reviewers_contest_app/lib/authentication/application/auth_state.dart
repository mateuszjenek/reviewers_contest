part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class Authenticated extends AuthState {
  final AccessToken token;

  Authenticated(this.token);
}

class Authenticating extends AuthState {}

class AuthenticatingFailed extends AuthState {}

class Unauthenticated extends AuthState {}
