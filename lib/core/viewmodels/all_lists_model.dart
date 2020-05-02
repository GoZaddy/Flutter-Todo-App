import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/services/UserInfoService.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';

class AllListsModel extends BaseModel{
  UserInfoService _userService = new UserInfoService();
  List<DocumentSnapshot> lists;

  Future getLists(String uid) async{
    setState(ViewState.Busy);
    lists = await _userService.getUserLists(uid);
    setState(ViewState.Idle);
  }
}