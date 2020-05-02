import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';

class ListModel extends BaseModel{

  List<DocumentSnapshot> todos;
  Future getListTodos(CollectionReference ref) async{
    setState(ViewState.Busy);
    var documents = await ref.getDocuments();
    todos =  documents.documents;
    print("todos debugging" + todos.toString());
    setState(ViewState.Idle);
    
  }
}