import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/entities/ListTodo.dart';

class ListTodoModel extends ListTodo{

  ListTodoModel({
    @required isDone,
    @required title,
    details,
    @required todoId,
    @required listId
  }) : super(
    isDone: isDone,
    title: title,
    details: details,
    todoId: todoId,
    listId: listId
  );

  factory ListTodoModel.fromFirestoreInfo({String listId, DocumentSnapshot todoDoc}){
    return ListTodoModel(
      isDone: todoDoc['isDone'],
      title: todoDoc['title'],
      details: todoDoc['details'],
      todoId: todoDoc.documentID,
      listId: listId
    );
  }


  
}