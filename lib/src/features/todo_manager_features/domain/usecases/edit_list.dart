import 'package:flutter/material.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/repositories/todo_manager_repository.dart';
import 'package:meta/meta.dart';

class EditListTitle {
  final TodoManagerRepository repository;

  EditListTitle(this.repository);

  void call({@required String uid,@required String listId,@required String newTitle}){
    repository.updateListTitle(
      uid: uid,
      listId: listId,
      newTitle: newTitle
    );
  }
}

class DeleteList {
  final TodoManagerRepository repository;

  DeleteList(this.repository);

  void call({@required String uid,@required String listId}){
    repository.deleteList(
      uid: uid,
      listId: listId,
    );
  }
}

class AddListTodo {
  final TodoManagerRepository repository;

  AddListTodo(this.repository);

  void call({@required String uid,@required String listId,@required String todoTitle}){
    repository.addNewTodo(
      uid: uid,
      listId: listId,
      todoTitle: todoTitle
    );
  }
}

class EditBackgroundColor {
  final TodoManagerRepository repository;

  EditBackgroundColor(this.repository);

  void call({@required String uid,@required String listId,@required Color newColor}){
    repository.setBackgroundColor(
      uid: uid,
      listId: listId,
      newColor: newColor
    );
  }
}

class ReorderListTodo {}
