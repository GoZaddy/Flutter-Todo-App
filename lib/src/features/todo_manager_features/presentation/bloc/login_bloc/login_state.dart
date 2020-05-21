part of 'login_bloc.dart';

@immutable
class LoginState{
  final bool isSuccess;
  final bool isFailure;
  final bool isSubmitting;
  final String errorMessage;

  LoginState({
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isSubmitting,
    this.errorMessage
  });

  factory LoginState.empty(){
    return LoginState(
      isFailure: false,
      isSubmitting: false,
      isSuccess: false
    );
  }

  factory LoginState.loading(){
    return LoginState(
      isFailure: false,
      isSubmitting: true,
      isSuccess: false
    );
  }

  factory LoginState.failure(){
    return LoginState(
      isFailure: true,
      isSubmitting: false,
      isSuccess: false,
      //errorMessage: message
    );
  }

  factory LoginState.success(){
    return LoginState(
      isFailure: false,
      isSubmitting: false,
      isSuccess: true
    );
  }
}


