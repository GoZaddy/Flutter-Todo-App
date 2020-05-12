import 'package:meta/meta.dart';
class ListTodo{
  bool isDone;
  String title;
  String details;
  String todoId;
  String listId;

  

  ListTodo({
    @required this.isDone,
    @required this.title,
    this.details,
    this.todoId,
    this.listId
  });

  
}