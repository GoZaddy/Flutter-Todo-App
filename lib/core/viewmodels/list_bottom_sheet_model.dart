import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/Constants.dart';
import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';

class ListBottomSheetModel extends BaseModel{

  List<DocumentSnapshot> todosInThisList;

  Future getListTodos(CollectionReference ref) async{
    setState(ViewState.Busy);
    var documents = await ref.getDocuments();
    todosInThisList = documents.documents;
    setState(ViewState.Idle);
  }

  void setBackgroundColor(Color newColor, DocumentReference ref){
    ref.updateData({
      "backgroundColor": colorToHex(newColor)
    });
  }

  void updateTitle(DocumentReference ref, String newTitle) {
    ref.updateData({"title": newTitle});
  }

   void addNewTodo(CollectionReference ref, String todoTitle) {
     ref.add(
       {"title": todoTitle, "isDone": false, "details": ""}
     );
   }

   void deleteList(DocumentReference ref) {
     ref.delete();
   }
}