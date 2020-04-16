import 'package:flutter/material.dart';

class ListTodo{
  bool isDone;
  String title;
  String details;

  ListTodo({
    @required this.isDone,
    @required this.title,
    this.details
  });
}