import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/services/UserInfoService.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';

class AllQuickNotesModel extends BaseModel{
   UserInfoService _userService = new UserInfoService();
  List<DocumentSnapshot> quickNotes;

  Future getQuickNotes(String uid) async{
    setState(ViewState.Busy);
    quickNotes = await _userService.getUserNotes(uid);
    setState(ViewState.Idle);
  }
}