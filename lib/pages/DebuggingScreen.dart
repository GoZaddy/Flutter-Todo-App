import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/User.dart';
import 'package:todo_app/services/AuthService.dart';

class DebuggingScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  onPressed: (){
                    AuthService().googleSignIn();
                  },
                  child: Text("Sign in"),
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  onPressed: (){
                    AuthService().signOut();
                  },
                  child: Text("Sign out"),
                )
              ],
            ),
            SizedBox(height: 40),
            Text(user.displayName)
          ],
        ),
      ),
    );
  }
}