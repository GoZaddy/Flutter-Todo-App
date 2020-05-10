import 'package:flutter/material.dart';
import 'package:todo_app/src/blocs/auth_bloc.dart';

class AuthBlocProvider extends InheritedWidget{
  final bloc = AuthBloc();

  AuthBlocProvider({Key key, Widget child}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static AuthBloc of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<AuthBlocProvider>()).bloc;
  }
}