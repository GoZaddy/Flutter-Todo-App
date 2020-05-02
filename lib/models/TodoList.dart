import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/Constants.dart';
import 'package:todo_app/models/ListTodo.dart';

class TodoList {
  Color backgroundColor;
  String listTitle;
  List<ListTodo> listOfTodos;
  String listId;
  Stream<QuerySnapshot> listOfTodosStream;

  Firestore _db = Firestore.instance;

  TodoList(
      {this.backgroundColor,
      @required this.listTitle,
      this.listOfTodos,
      this.listOfTodosStream,
      this.listId});

  void setBackgroundColor(String userId, Color newColor) {
    _db
        .collection("lists")
        .document(userId)
        .collection("userLists")
        .document(listId)
        .updateData({"backgroundColor": colorToHex(newColor)});
    backgroundColor = newColor;
  }

  void updateTitle(String userId, String newTitle) {
    _db
        .collection("lists")
        .document(userId)
        .collection("userLists")
        .document(listId)
        .updateData({"title": newTitle});
  }

  void addNewTodo(String todoTitle, String userId) {
    _db
        .collection("lists")
        .document(userId)
        .collection("userLists")
        .document(listId)
        .collection("todos")
        .add({"title": todoTitle, "isDone": false, "details": ""});
  }

  void deleteList(String userId) {
    _db
        .collection("lists")
        .document(userId)
        .collection("userLists")
        .document(listId)
        .delete();
  }
}
