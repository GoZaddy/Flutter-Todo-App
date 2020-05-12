import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/core/error/exceptions.dart';

import '../../../../core/constants/Constants.dart';
import '../../domain/entities/ListTodo.dart';



class FirestoreInteractions {
  Firestore _db = Firestore.instance;

  //Utility stuff
  DocumentReference _getSpecificListDocument({@required String uid, @required String listId}){
    return _db.collection("lists").document(uid).collection("userLists").document(listId);
  }

  DocumentReference _getSpecificQuickNoteDocument({@required String uid, @required String quickNoteId}){
    return _db.collection("quickNotes").document(uid).collection("userNotes").document(quickNoteId);
  }
  
  DocumentReference _getSpecificListTodoDocument({@required String uid, @required String listId, @required String todoId}){
    return _getSpecificListDocument(uid: uid, listId: listId).collection("todos").document(todoId);
  }
  //Dashboard stuff

  Stream<QuerySnapshot> fetchQuickNotes(String uid) {
    try{
      return _db
        .collection("quickNotes")
        .document(uid)
        .collection("userNotes")
        .orderBy("priority")
        .snapshots();
    }

    on Exception{
      throw FetchQuickNotesException();
    }
    
  }

  Stream<QuerySnapshot> fetchLists(String uid) {
    try{
      return _db
        .collection("lists")
        .document(uid)
        .collection("userLists")
        .snapshots();
    }
    on Exception{
      throw FetchListsException();
    }
    
  }

  Stream<QuerySnapshot> getListTodos({String uid, String listId}) {
    try{
      return _db
        .collection("lists")
        .document(uid)
        .collection("userLists")
        .document(listId)
        .collection("todos")
        .orderBy("isDone")
        .snapshots();
    }
    on Exception{
      throw GetListTodosException();
    }
    
  }

  void addQuickNote({String uid, Map<String, dynamic> quickNoteData}) {
    _db.collection("quickNotes").document(uid).collection("userNotes").add({
      'title': quickNoteData['title'],
      'priority': quickNoteData['priority'],
      'isDone': quickNoteData['isDone']
    });
  }

  Future addList({String uid, String listTitle, List<ListTodo> listOfTodos,
      String listBackgroundColor}) async {

    return _db.collection("lists").document(uid).collection("userLists").add({
      "title": listTitle,
      "backgroundColor": listBackgroundColor.toString()
    }).then((DocumentReference doc) {
      listOfTodos.forEach((ListTodo todo) {
        doc.collection("todos").add({
          "isDone": todo.isDone,
          "title": todo.title,
          "details": todo.details
        });
      });
    });
  }


  //Quick Note stuff

  void setQuickNoteIsDone({String uid, String quickNoteId, bool isDone}){
  _getSpecificQuickNoteDocument(uid: uid, quickNoteId: quickNoteId).updateData({
    'isDone': isDone
  });
}

  void setQuickNoteTitle({String uid, String quickNoteId, String newTitle}){
  _getSpecificQuickNoteDocument(uid: uid, quickNoteId: quickNoteId).updateData({
    'title': newTitle
  });
}

  void deleteQuickNote({String uid, String quickNoteId}){
  _getSpecificQuickNoteDocument(uid: uid, quickNoteId: quickNoteId).delete();
}

  //List stuff
  void setBackgroundColor({String uid, String listId, Color newColor}){
  _getSpecificListDocument(uid: uid, listId: listId).updateData({
    "backgroundColor": colorToHex(newColor)
  });
} 

  void updateListTitle({String uid, String listId, String newTitle}){
  _getSpecificListDocument(uid: uid, listId: listId).updateData({
    "title": newTitle
  });
}

  void addNewTodo({String uid, String listId, String todoTitle}){
  _getSpecificListDocument(uid: uid, listId: listId).collection("todos").add({
    "title": todoTitle, "isDone": false, "details": ""
  });
}

  void deleteList({String uid, String listId}){
  _getSpecificListDocument(uid: uid, listId: listId).delete();
}

  //list-todo stuff
  void setListTodoIsDone({String uid, String listId, String todoId, bool isDone}){
    _getSpecificListTodoDocument(uid: uid, listId: listId, todoId: todoId).updateData({
      "isDone": isDone
    });
  }

}
