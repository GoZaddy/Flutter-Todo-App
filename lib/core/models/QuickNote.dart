import 'package:flutter/material.dart';
import 'package:todo_app/core/models/Priority.dart';
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


  /*set itemPriority(Priority newPriority){
    this.priority = newPriority;
  } */
  
  
}