
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/UI/widgets/slide_animation_provider.dart';
import 'package:todo_app/src/blocs/auth_bloc.dart';
import 'package:todo_app/src/enums/enums.dart';



class LoginPage extends StatelessWidget {
  final AuthBloc bloc;
  LoginPage({
    @required this.bloc
  });

   Widget _buildProgressIndicator (){
    return StreamBuilder(
      initialData: false,
      stream: bloc.authState,
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


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                SlideAnimationWrapper(
                  fadeDuration: Duration(milliseconds: 1000),
                  slideDuration: Duration(milliseconds: 1500),
                  child: Text(
                    "Hello!",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 50.0,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                ),
                SlideAnimationWrapper(
                  fadeDuration: Duration(milliseconds: 1200),
                  slideDuration: Duration(milliseconds: 1700),
                  child: Text(
                    "Seems you aren't signed in",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w200,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SlideAnimationWrapper(
                  fadeDuration: Duration(milliseconds: 1500),
                  slideDuration: Duration(milliseconds: 1900),
                  child: Text(
                    "Please sign in with your Google\naccount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w200,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SlideAnimationWrapper(
                  fadeDuration: Duration(milliseconds: 1600),
                  slideDuration: Duration(milliseconds: 2000),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    onPressed: () async{
                      await bloc.signInWithGoogle();
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

