import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/Login.dart';
import 'package:todo_app/models/User.dart';
import 'package:todo_app/pages/Dashboard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    print(user);
     if(user == null){
       return LoginPage();
     }
     else{
       return DashboardScreen();
     }
  }
}