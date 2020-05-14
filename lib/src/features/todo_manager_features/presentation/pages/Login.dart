
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/user/user.dart';
import 'package:todo_app/src/features/todo_manager_features/data/datasources/auth_service.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/widgets/slide_animation_provider.dart';

import '../../../../injection_container.dart';




class LoginPage extends StatefulWidget {
  
  
 

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  
  Widget _buildProgressIndicator (BuildContext context){
    
    return BlocBuilder(
      bloc: BlocProvider.of<LoginBloc>(context),
      builder: (context, LoginState state){
        if(state.isSubmitting){
          return CircularProgressIndicator();
        }
        else if(state.isFailure){
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
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: BlocListener(
          bloc: BlocProvider.of<LoginBloc>(context),
          listener: (context, LoginState state) async{
            if (state.isSuccess) {
              await sl.allReady();
              BlocProvider.of<AuthBloc>(context).add(LoggedIn());   
            }
            else if(state.isFailure){
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        state.errorMessage,
                        style: TextStyle(
                          color: Colors.red[500],
                          fontFamily: "Poppins",
                          fontSize: 25
                        ),
                      ),
                    ],
                  )
                )
              );
            }
          },
          child: Center(
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
                      onPressed: (){
                        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
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
                  
                 _buildProgressIndicator(context)
                  
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}

