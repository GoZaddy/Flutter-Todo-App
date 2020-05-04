
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/UI/pages/AddNewList.dart';
import 'package:todo_app/src/UI/pages/AddQuickNote.dart';
import 'package:todo_app/src/UI/pages/HomePage.dart';
import 'package:todo_app/src/bloc_providers/dashboard_bloc_provider.dart';
import 'package:todo_app/src/resources/auth_service.dart';
import 'package:todo_app/src/models/User.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: _authService.user,
      child: DashboardBlocProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
            primaryColor: Color(0xff657AFF),
            accentColor: Color(0xff4F5578),
            primarySwatch: Colors.blue,
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => HomePage(),
            "/addQuickNote": (context) => AddQuickNote(),
            "/addList": (context) => AddList()
          },
        ),
      ),
    );
  }
}

