import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/models/ListTodo.dart';

class TodoList {
  Color backgroundColor;
  String listTitle;
  List<ListTodo> listOfTodos;
  CollectionReference listTodosPath;
  DocumentReference listRef;

  TodoList(
      {this.backgroundColor,
      @required this.listTitle,
      this.listOfTodos,
      this.listTodosPath,
      this.listRef});
}
