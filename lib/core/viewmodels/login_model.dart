import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/services/AuthService.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';

class LoginModel extends BaseModel{
  AuthService _auth = new AuthService();


  Future googleSignIn() async{
    setState(ViewState.Busy);
    await _auth.googleSignIn();
    setState(ViewState.Idle);
  }
}