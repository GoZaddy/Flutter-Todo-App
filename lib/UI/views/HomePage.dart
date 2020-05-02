import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/views/Login.dart';
import 'package:todo_app/core/models/User.dart';
import 'package:todo_app/UI/views/Dashboard.dart';

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