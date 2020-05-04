import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/src/blocs/base_bloc.dart';
import 'package:todo_app/src/enums/enums.dart';
import 'package:todo_app/src/resources/repository.dart';

class AuthBloc implements BaseBloc{
  Repository _repository = new Repository();

  StreamController<AuthState> _authState = new StreamController<AuthState>.broadcast();
  

  Stream<AuthState> get authState => _authState.stream;

  Future<FirebaseUser> signInWithGoogle() async{
    try{
      _authState.sink.add(AuthState.loading);
      FirebaseUser user = await _repository.signInWithGoogle();
      _authState.sink.add(AuthState.success);
      return user;
    }
    catch(e){
      _authState.sink.add(AuthState.error);
      print(e);
    }
  }

  void signOut() async{
    await _repository.signOut();
  }

  @override
  void dispose() {
    _authState.close();
  }



}