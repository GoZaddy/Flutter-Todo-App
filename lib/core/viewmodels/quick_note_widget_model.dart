import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/viewmodels/all_quick_notes_models.dart';
import 'package:todo_app/core/viewmodels/base_model.dart';

class QuickNoteModel extends BaseModel{

  void setItemIsDone(DocumentReference docRef, bool isDone){
    docRef.updateData({
      'isDone': isDone
    });
    notifyListeners();
  }

  void delete(DocumentReference docRef){
    docRef.delete().then((val){
      AllQuickNotesModel().notifyListeners();
    });
   
  }

  void setItemTitle(DocumentReference docRef, String newTitle){
    docRef.updateData({
      'title': newTitle
    }).then((val){
      AllQuickNotesModel().notifyListeners();
    });
    
  }

  
}