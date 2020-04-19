import 'package:flutter/material.dart';
import 'package:todo_app/models/Priority.dart';

class QuickNote{
  String id;
  Priority priority;
  bool isDone;
  String title;

  QuickNote({
    @required this.priority,
    @required this.isDone,
    @required this.title,
    this.id
  });

//do a from doucment named constructor
 
  set itemPriority(Priority newPriority){
    this.priority = newPriority;
  } 
  void setItemIsDone(bool isDone){
    
  }
  set itemTitle(String title){
    this.title = title;
  }

  

  
}