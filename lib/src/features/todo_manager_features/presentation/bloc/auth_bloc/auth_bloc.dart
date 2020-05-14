import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/user/user.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    @required AuthRepository authRepository
  }): assert(authRepository != null), _authRepository = authRepository;

  @override
  AuthState get initialState => Uninitialised();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AppStarted){
      yield* _mapAppStartedToState();
    }
    else if (event is LoggedIn){
      yield AuthAuthenticated(await _authRepository.getUser());
    }
    else if (event is LoggedOut){
      await _authRepository.signOut();
      yield AuthUnauthenticated();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async*{
  try{
    final isSignedIn = await _authRepository.isSignedIn();
    if(isSignedIn || await _authRepository.getUser() == null){
      final user = await _authRepository.getUser();
      yield AuthAuthenticated(user);
    }
    else{
      yield AuthUnauthenticated();
    }
  }
  catch(_){
    yield AuthUnauthenticated();
  }
}

}

