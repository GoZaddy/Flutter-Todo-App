
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/blocs/auth_bloc.dart';
import 'package:todo_app/src/enums/enums.dart';



class LoginPage extends StatefulWidget {
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc authBloc;
  @override
  void didChangeDependencies() {
    authBloc = Provider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    
    
    Widget _buildProgressIndicator (){
    return StreamBuilder(
      initialData: false,
      stream: authBloc.authState,
      builder: (context, snapshot){
        if(snapshot.data == AuthState.loading){
          return CircularProgressIndicator();
        }
        else if(snapshot.data == AuthState.error){
          return Text(
            "Error logging in"
          );
        }
        else{
          return SizedBox(height:0);
        }
      }
    );
    
  }
    return Scaffold(
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
                    await authBloc.signInWithGoogle();
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
                
               _buildProgressIndicator()
                
              ],
            ),
          ),
        ),
      
    );
  }
}

