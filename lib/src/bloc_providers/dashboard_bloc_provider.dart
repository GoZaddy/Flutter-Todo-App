import 'package:flutter/material.dart';
import 'package:todo_app/src/blocs/dashboard_bloc.dart';

class DashboardBlocProvider extends InheritedWidget{
  final bloc = DashboardBloc();

  DashboardBlocProvider({Key key, Widget child}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static DashboardBloc of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<DashboardBlocProvider>()).bloc;
  }
}