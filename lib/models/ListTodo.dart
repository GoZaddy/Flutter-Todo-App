import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListTodo{
  bool isDone;
  String title;
  String details;
  String todoId;
  String listId;

  Firestore _db =  Firestore.instance; 

  ListTodo({
    @required this.isDone,
    @required this.title,
    this.details,
    this.todoId,
    this.listId
  });

  void setIsDone(String userUid,){
    _db.collection("lists").document(userUid).collection("userLists").document(listId).collection("todos").document(todoId).updateData({
      "isDone": this.isDone

    });
  }
}