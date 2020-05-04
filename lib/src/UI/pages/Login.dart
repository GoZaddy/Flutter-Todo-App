
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/UI/widgets/slide_animation_provider.dart';
import 'package:todo_app/src/blocs/auth_bloc.dart';
import 'package:todo_app/src/enums/enums.dart';



class LoginPage extends StatefulWidget {
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  AuthBloc authBloc;
 /* AnimationController _animationController;
  AnimationController _animationFadeController;
  Animation<Offset> _offsetAnimation;
  Animation<double> _opacity;*/
  @override
  void initState() {
    /*_animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this
    )..forward();

    _animationFadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this
    )..forward();
    
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0),
      
      end: Offset(0,0)
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack
        
      )
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(
      CurvedAnimation(parent: _animationFadeController, curve: Curves.ease)
    );*/

    super.initState();
    
    
  }

  @override
  void didChangeDependencies() {
    authBloc = Provider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
    //_animationController.dispose();
  }

  
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

