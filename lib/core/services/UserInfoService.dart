import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/models/ListTodo.dart';

class UserInfoService {
  final Firestore _db = Firestore.instance;

  Future<List<DocumentSnapshot>> getUserLists(String uid) async {
    var documents = await _db
        .collection("lists")
        .document(uid)
        .collection("userLists")
        .getDocuments();
    return documents.documents;
  }

  Future<List<DocumentSnapshot>> getUserNotes(String uid) async {
    var documents = await _db
        .collection("quickNotes")
        .document(uid)
        .collection("userNotes")
        .orderBy("priority")
        .getDocuments();

    return documents.documents;
  }

  Future addQuickNote(String uid, Map<String, dynamic> quickNoteData) async {
    _db.collection("quickNotes").document(uid).collection("userNotes").add({
      'title': quickNoteData['title'],
      'priority': quickNoteData['priority'],
      'isDone': quickNoteData['isDone']
    });
  }

  Future addList(
      {String uid,
      String listTitle,
      List<ListTodo> listOfTodos,
      String listBackgroundColor}) async {
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
}
