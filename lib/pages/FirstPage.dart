import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double _imageSize = 50.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), () {
      print("run man");
      setState(() {
        _imageSize = 200.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 300),(){
      authService.user.listen((user) {
        print("i run");
        if (user != null) {
          Navigator.popAndPushNamed(context, "/dashboard");
        } else {
          Navigator.popAndPushNamed(context, "/");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /**/

    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          width: _imageSize,
          child: Image.asset(
            "assets/logo.png",
          ),
        ),
      ),
    );
  }
}
