import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/ListTodo.dart';
class TodoList{
  Color backgroundColor;
  String listTitle;
  List<ListTodo> listOfTodos;
  String listId;
  Stream<QuerySnapshot> listOfTodosStream;

  TodoList({
    this.backgroundColor,
    @required this.listTitle,
    this.listOfTodos,
    this.listOfTodosStream
  });
  
  /*{

listOfTodos = [];
    listOfTodosStream.listen((QuerySnapshot todo){
      todo.documents.forEach((snap){
        listOfTodos.add(new ListTodo(isDone: snap["isDone"], title: snap["title"], details:snap["details"])); 
        print(snap["title"]);
      });
    });
  }*/




}