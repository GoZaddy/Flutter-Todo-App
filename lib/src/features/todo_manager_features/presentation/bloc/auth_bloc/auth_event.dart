part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  final List properties;
  const AuthEvent([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class AppStarted extends AuthEvent{}

class LoggedIn extends AuthEvent{}

class LoggedOut extends AuthEvent{}
