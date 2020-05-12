
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/core/constants/Constants.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/entities/List.dart';


class ListModel extends ListEntity {

  ListModel({
    @required backgroundColor,
    @required listTitle,
    @required listId,
    @required listOfTodosStream
  }): super(backgroundColor: backgroundColor, listTitle:listTitle, listOfTodosStream:listOfTodosStream, listId: listId);

  factory ListModel.fromFirestoreDoc(DocumentSnapshot doc){
    return ListModel(
      backgroundColor: hexToColor(doc["backgroundColor"]) ,
      listTitle: doc["title"],
      listId: doc.documentID,
      listOfTodosStream: doc.reference.collection("todos").orderBy("isDone").snapshots().asBroadcastStream()
    );
  }

  

  
}
