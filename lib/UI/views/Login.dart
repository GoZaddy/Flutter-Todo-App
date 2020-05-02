

import 'package:flutter/material.dart';

import 'package:todo_app/UI/views/base_view.dart';
import 'package:todo_app/UI/widgets/NoWidget.dart';
import 'package:todo_app/core/enums/viewstate.dart';



import 'package:todo_app/core/viewmodels/login_model.dart';


class LoginPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    
    
    
    Widget _buildProgressIndicator ({ViewState state}){
    
        if(state == ViewState.Busy){
          return CircularProgressIndicator();
        }
        else{
          return NoWidget();
        }
    }
    
    
  
    return BaseView<LoginModel>(
      builder: (context, model, child) =>
          Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  Text(
                    "Hello!",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 50.0,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  Text(
                    "Seems you aren't signed in",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w200,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Please sign in with your Google\naccount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w200,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  SizedBox(height: 40),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    onPressed: () async{
                      model.googleSignIn();
                    },
                    child: Text(
                      "Sign in with Google",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    )
                  ),
                  SizedBox(height: 20.0),
                  
                 _buildProgressIndicator(state: model.state)
                  
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}

