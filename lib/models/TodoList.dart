import 'package:flutter/material.dart';
import 'package:todo_app/models/ListTodo.dart';
class TodoList{
  Color backgroundColor;
  String listTitle;
  List<ListTodo> listOfTodos;
  String listId;

  TodoList({
    this.backgroundColor,
    @required this.listTitle,
    this.listOfTodos
  });


}