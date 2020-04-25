import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/ListTodo.dart';

class User {
  String uid;
  String displayName;
  bool exists = false;

  final Firestore _db = Firestore.instance;

  User.fromUid(FirebaseUser user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
    this.exists = true;
  }

  Stream<QuerySnapshot> get quickNotes {
    return _db
        .collection("quickNotes")
        .document(uid)
        .collection("userNotes")
        .orderBy("priority")
        .snapshots();
  }

  void addQuickNote(Map<String, dynamic> quickNoteData) {
    _db.collection("quickNotes").document(uid).collection("userNotes").add({
      'title': quickNoteData['title'],
      'priority': quickNoteData['priority'],
      'isDone': quickNoteData['isDone']
    });
  }

  

  void addList(String listTitle, List<ListTodo> listOfTodos,
      String listBackgroundColor) async {
    _db.collection("lists").document(uid).collection("userLists").add({
      "title": listTitle,
      "backgroundColor": listBackgroundColor.toString()
    }).then((DocumentReference doc) {
      listOfTodos.forEach((ListTodo todo) {
        doc.collection("todos").add({
          "isDone": todo.isDone,
          "title": todo.title,
          "details": todo.details
        });
      });
    });
  }

  Stream<QuerySnapshot> get lists {
    return _db
        .collection("lists")
        .document(uid)
        .collection("userLists")
        .snapshots();
  }

  Stream<QuerySnapshot> getListTodos(String docId) {
    List<ListTodo> _listOfTodos = [];
    return _db
        .collection("lists")
        .document(uid)
        .collection("userLists")
        .document(docId)
        .collection("todos")
        .snapshots();
  }
}
