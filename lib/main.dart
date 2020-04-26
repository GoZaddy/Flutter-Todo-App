import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/AddNewList.dart';
import 'package:todo_app/pages/AddQuickNote.dart';
import 'package:todo_app/pages/Dashboard.dart';
import 'package:todo_app/pages/FirstPage.dart';
import 'package:todo_app/pages/Login.dart';
import 'package:todo_app/services/AuthService.dart';
import 'package:todo_app/models/User.dart';

Future<void> main() async => runApp(MyApp());
AuthService authService = new AuthService();
User currentUser;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
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
              "/": (context) => FirstPage(),
              "/dashboard": (context) => DashboardScreen(),
              "/addQuickNote": (context) => AddQuickNote(),
              "/addList": (context) => AddList()
            }, 
          ),
        ),
    );
  }
}

Future<Widget> getFirstPage() async{
  return StreamBuilder<FirebaseUser>(
    stream: authService.user,
    builder: (context, snapshot){
      if(snapshot.hasData && !snapshot.data.isAnonymous){
        return DashboardScreen();

      }
      return LoginPage();
    },
  );
}

