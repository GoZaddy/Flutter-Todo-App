import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';

class ListToDoModel extends BaseModel{

  void setIsDone(DocumentReference todoPath, bool isDone){
    todoPath.updateData({
      "isDone": isDone
    });
  }

}