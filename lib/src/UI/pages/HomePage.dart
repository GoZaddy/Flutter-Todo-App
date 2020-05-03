import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/UI/pages/Login.dart';
import 'package:todo_app/src/bloc_providers/dashboard_bloc_provider.dart';
import 'package:todo_app/src/blocs/auth_bloc.dart';
import 'package:todo_app/src/blocs/dashboard_bloc.dart';
import 'package:todo_app/src/models/User.dart';
import 'package:todo_app/src/UI/pages/Dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthBloc _authBloc = AuthBloc();
  DashboardBloc _dashboardBloc;

  @override
  void didChangeDependencies() {
    _dashboardBloc = DashboardBlocProvider.of(context);
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    print("disposing home page");
    _dashboardBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    print(user);
     if(user == null){
        return Provider<AuthBloc>.value(
          value: _authBloc,
          child: LoginPage()
        );
     }
     else {
        return DashboardScreen(
          bloc: _dashboardBloc
        );
      }
  }
}