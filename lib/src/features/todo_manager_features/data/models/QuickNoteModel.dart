import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/src/core/priority/Priority.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/entities/QuickNote.dart';


class QuickNoteModel extends QuickNote{
  QuickNoteModel({
    @required priority,
    @required isDone,
    @required title,
    @required quickNoteId
  }): super(
    priority: priority,
    isDone: isDone,
    title: title,
    quickNoteId: quickNoteId
  );


  factory QuickNoteModel.fromFirestoreDoc(DocumentSnapshot doc){
    return QuickNoteModel(
      priority: Priority.fromPriorityValue(doc['priority']),
      isDone: doc['isDone'],
      title: doc['title'],
      quickNoteId: doc.documentID
    );
  }

  
}