part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final List properties;
  const AuthState([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class Uninitialised extends AuthState {
}


class AuthAuthenticated extends AuthState{
  final User user;

  AuthAuthenticated(this.user): super([user]);

}

class AuthUnauthenticated extends AuthState{
  
}

class AuthError extends AuthState{
  final String message;

  AuthError(this.message) : super([message]);

}
