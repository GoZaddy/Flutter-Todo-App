import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/models/ListTodo.dart';


class TodoList {
  Color backgroundColor;
  String listTitle;
  List<ListTodo> listOfTodos;
  String listId;
  Stream<QuerySnapshot> listOfTodosStream;
  


  TodoList({
    this.backgroundColor,
    @required this.listTitle,
    this.listOfTodos,
    this.listId,
    this.listOfTodosStream
  });

  

  
}
