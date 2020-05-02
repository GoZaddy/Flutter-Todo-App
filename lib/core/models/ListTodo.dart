import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListTodo{
  bool isDone;
  String title;
  String details;
  DocumentReference todoPath;

  

  ListTodo({
    @required this.isDone,
    @required this.title,
    this.details,
    this.todoPath
  });

  
}