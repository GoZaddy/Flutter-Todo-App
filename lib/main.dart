import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/Dashboard.dart';
import 'package:todo_app/pages/Login.dart';
import 'package:todo_app/services/AuthService.dart';
import 'package:todo_app/models/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthService authService = new AuthService();
    User currentUser;
    authService.user.listen((user){
      currentUser = User.fromUid(user);
    });
    return Provider<AuthService>(
        create: (_) => authService,
        child: Provider<User>(
          create: (_) => currentUser,
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
              "/": (context) => LoginPage(),
              "/dashboard": (context) => DashboardScreen()
            }, 
          ),
        ),
    );
  }
}

