import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/src/models/ListTodo.dart';
import 'package:todo_app/src/resources/auth_service.dart';
import 'package:todo_app/src/resources/firestore_interactions.dart';
import 'package:flutter/material.dart';

class Repository {
  final _firestoreInteractions = FirestoreInteractions();
  final _authService = AuthService();

  //Authentication stuff:

  Future<FirebaseUser> signInWithGoogle() => _authService.googleSignIn();

  Future  signOut() => _authService.signOut();

  //Firestore stuff:
  Stream<QuerySnapshot> fetchQuickNotes(String uid) => _firestoreInteractions.fetchQuickNotes(uid);

  Stream<QuerySnapshot> fetchLists(String uid) => _firestoreInteractions.fetchLists(uid);

  Stream<QuerySnapshot> getListTodos({String uid, String listId}) => _firestoreInteractions.getListTodos(uid: uid, listId: listId);

  void addQuickNote({String uid, Map<String, dynamic> quickNoteData}) => _firestoreInteractions.addQuickNote(uid: uid, quickNoteData: quickNoteData);

  Future addList({String uid, String listTitle, List<ListTodo> listOfTodos, String listBackgroundColor}) => _firestoreInteractions.addList(
    uid: uid, listBackgroundColor: listBackgroundColor, listOfTodos: listOfTodos, listTitle: listTitle
  );

  void setQuickNoteIsDone({String uid, String quickNoteId, bool isDone}) => _firestoreInteractions.setQuickNoteIsDone(uid: uid, quickNoteId: quickNoteId, isDone: isDone);

  void setQuickNoteTitle({String uid, String quickNoteId, String newTitle}) => _firestoreInteractions.setQuickNoteTitle(uid: uid, quickNoteId: quickNoteId, newTitle: newTitle);

  void deleteQuickNote({String uid, String quickNoteId}) => _firestoreInteractions.deleteQuickNote(uid: uid, quickNoteId: quickNoteId);

  void setBackgroundColor({String uid, String listId, Color newColor}) => _firestoreInteractions.setBackgroundColor(uid: uid, listId: listId, newColor: newColor);

  void updateListTitle({String uid, String listId, String newTitle}) => _firestoreInteractions.updateListTitle(uid: uid, listId: listId, newTitle: newTitle);

  void addNewTodo({String uid, String listId, String todoTitle}) => _firestoreInteractions.addNewTodo(uid: uid, listId: listId, todoTitle: todoTitle);

  void deleteList({String uid, String listId}) => _firestoreInteractions.deleteList(uid: uid, listId: listId);

  void setListTodoIsDone({String uid, String listId, String todoId, bool isDone}) => _firestoreInteractions.setListTodoIsDone(uid: uid, listId: listId, isDone: isDone, todoId: todoId);




}