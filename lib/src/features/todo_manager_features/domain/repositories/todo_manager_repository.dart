import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/entities/ListTodo.dart';

abstract class TodoManagerRepository {
  Stream<QuerySnapshot> fetchQuickNotes(String uid);

  Stream<QuerySnapshot> fetchLists(String uid);

  Stream<QuerySnapshot> getListTodos({String uid, String listId}); 

  void addQuickNote({String uid, Map<String, dynamic> quickNoteData}); 

  Future addList({String uid, String listTitle, List<ListTodo> listOfTodos, String listBackgroundColor});
  void setQuickNoteIsDone({String uid, String quickNoteId, bool isDone});

  void setQuickNoteTitle({String uid, String quickNoteId, String newTitle});

  void deleteQuickNote({String uid, String quickNoteId});

  void setBackgroundColor({String uid, String listId, Color newColor});

  void updateListTitle({String uid, String listId, String newTitle});

  void addNewTodo({String uid, String listId, String todoTitle});

  void deleteList({String uid, String listId});

  void setListTodoIsDone({String uid, String listId, String todoId, bool isDone});


}