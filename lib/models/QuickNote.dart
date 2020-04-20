import 'package:flutter/material.dart';
import 'package:todo_app/models/Priority.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuickNote{
  DocumentReference documentPath;
  Priority priority;
  bool isDone;
  String title;


  QuickNote({
    @required this.priority,
    @required this.isDone,
    @required this.title,
    this.documentPath
  });

//do a from doucment named constructor
 
  set itemPriority(Priority newPriority){
    this.priority = newPriority;
  } 
  void setItemIsDone(){
    this.documentPath.updateData({
      'isDone': isDone
    });
  }
  set itemTitle(String title){
    this.title = title;
  }

  

  
}