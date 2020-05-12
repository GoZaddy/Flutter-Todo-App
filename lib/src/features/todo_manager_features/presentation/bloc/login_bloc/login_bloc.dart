import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository _authRepository;

  LoginBloc({
    @required AuthRepository authRepository,
  })  : assert(authRepository != null),
        _authRepository = authRepository;
  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginWithGooglePressed){
      yield LoginState.loading();
      final result  = await _authRepository.signInWithGoogle();
      yield result.fold(
        (failure) => LoginState.failure(),
        (user) => LoginState.success()
      );
    }
  }
}
