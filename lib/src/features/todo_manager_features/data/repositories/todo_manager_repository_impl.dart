import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';


import '../../domain/entities/ListTodo.dart';
import '../../domain/repositories/todo_manager_repository.dart';
import '../datasources/firestore_interactions.dart';

class TodoManagerRepositoryImpl implements TodoManagerRepository {
  final FirestoreInteractions firestoreInteractions;

  TodoManagerRepositoryImpl(this.firestoreInteractions);
  @override
  Future addList(
      {@required String uid,
      @required String listTitle,
      @required List<ListTodo> listOfTodos,
      String listBackgroundColor}) async {
    await firestoreInteractions.addList(
        uid: uid,
        listTitle: listTitle,
        listBackgroundColor: listBackgroundColor,
        listOfTodos: listOfTodos);
  }

  @override
  void addNewTodo({String uid, String listId, String todoTitle}) {
    firestoreInteractions.addNewTodo(
        uid: uid, listId: listId, todoTitle: todoTitle);
  }

  @override
  void addQuickNote({String uid, Map<String, dynamic> quickNoteData}) {
    firestoreInteractions.addQuickNote(uid: uid, quickNoteData: quickNoteData);
  }

  @override
  void deleteList({String uid, String listId}) {
    firestoreInteractions.deleteList(uid: uid, listId: listId);
  }

  @override
  void deleteQuickNote({String uid, String quickNoteId}) {
    deleteQuickNote(uid: uid, quickNoteId: quickNoteId);
  }

  @override
  Stream<QuerySnapshot> fetchLists(String uid) {
    return firestoreInteractions.fetchLists(uid);
  }

  @override
  Stream<QuerySnapshot> fetchQuickNotes(String uid) {
    return firestoreInteractions.fetchQuickNotes(uid);
  }

  @override
  Stream<QuerySnapshot> getListTodos({String uid, String listId}) {
    return firestoreInteractions.getListTodos(uid: uid, listId: listId);
  }

  @override
  void setBackgroundColor({String uid, String listId, Color newColor}) {
    firestoreInteractions.setBackgroundColor(
        uid: uid, listId: listId, newColor: newColor);
  }

  @override
  void setListTodoIsDone(
      {String uid, String listId, String todoId, bool isDone}) {
    firestoreInteractions.setListTodoIsDone(
        uid: uid, listId: listId, isDone: isDone, todoId: todoId);
  }

  @override
  void setQuickNoteIsDone({String uid, String quickNoteId, bool isDone}) {
    firestoreInteractions.setQuickNoteIsDone(
        uid: uid, isDone: isDone, quickNoteId: quickNoteId);
        print("worked");
  }

  @override
  void setQuickNoteTitle({String uid, String quickNoteId, String newTitle}) {
    firestoreInteractions.setQuickNoteTitle(
        uid: uid, quickNoteId: quickNoteId, newTitle: newTitle);
  }

  @override
  void updateListTitle({String uid, String listId, String newTitle}) {
    firestoreInteractions.updateListTitle(uid: uid, listId: listId, newTitle: newTitle);
  }
}
