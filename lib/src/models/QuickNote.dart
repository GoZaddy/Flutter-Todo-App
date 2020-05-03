import 'package:flutter/material.dart';
import 'package:todo_app/src/models/Priority.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuickNote{
  String quickNoteId;
  Priority priority;
  bool isDone;
  String title;


  QuickNote({
    @required this.priority,
    @required this.isDone,
    @required this.title,
    @required this.quickNoteId
  });


  
 /* void setItemIsDone(){
    this.documentPath.updateData({
      'isDone': isDone
    });
  }

  void setItemTitle(String newTitle){
    this.documentPath.updateData({
      'title': newTitle
    });
  }

  void delete(){
    this.documentPath.delete();
  }
  
  */

  

  
}