import 'package:flutter/material.dart';

class QuickNote{
  int priority;
  bool isDone;
  String title;

  QuickNote({
    @required this.priority,
    @required this.isDone,
    @required this.title
  });

//do a from doucment named constructor
  int get itemPriority => this.priority;
  bool get itemIsDone => this.isDone;
  String get itemTitle => this.title;

  set itemPriority(int newPriority){
    this.priority = newPriority;
  } 
  set itemIsDone(bool isDone){
    this.isDone = isDone;
  }
  set itemTitle(String title){
    this.title = title;
  }

  /*Color get priorityColor(int priority){
    switch (priority) {
      case :
        
        break;
      default:
    }
  }*/

}