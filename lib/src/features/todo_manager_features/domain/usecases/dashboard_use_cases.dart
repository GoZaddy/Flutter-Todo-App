import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/repositories/todo_manager_repository.dart';
import 'package:meta/meta.dart';
class FetchListTodos{
  final TodoManagerRepository repository;

  FetchListTodos(this.repository);

  Stream<QuerySnapshot> call({@required String uid, @required String listId}){
    return repository.getListTodos(
      uid: uid,
      listId: listId
    );
  }


}
class FetchQuickNotes{
  final TodoManagerRepository repository;

  FetchQuickNotes(this.repository);

  Stream<QuerySnapshot> call({@required String uid}){
    return repository.fetchQuickNotes(uid);
  }


}

class FetchLists{
  final TodoManagerRepository repository;

  FetchLists(this.repository);

  Stream<QuerySnapshot> call({@required String uid}){
    return repository.fetchLists(uid);
  }


}