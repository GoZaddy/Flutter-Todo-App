
import 'package:flutter/material.dart';


class ListEntity {
  Color backgroundColor;
  String listTitle;
  String listId;
  Stream listOfTodosStream;
  


  ListEntity({
    @required this.backgroundColor,
    @required this.listTitle,
    @required this.listId,
    @required this.listOfTodosStream
  });

  

  
}
