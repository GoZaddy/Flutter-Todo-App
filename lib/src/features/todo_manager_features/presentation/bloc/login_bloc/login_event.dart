part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  final List properties;
  const LoginEvent([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties]; 
}


class LoginWithGooglePressed extends LoginEvent{
  
}

