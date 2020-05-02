
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/AddNewList.dart';
import 'package:todo_app/pages/AddQuickNote.dart';
import 'package:todo_app/pages/HomePage.dart';
import 'package:todo_app/services/AuthService.dart';
import 'package:todo_app/models/User.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
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
    );
  }
}

