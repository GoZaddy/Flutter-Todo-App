import 'package:todo_app/src/features/todo_manager_features/domain/repositories/todo_manager_repository.dart';
import 'package:meta/meta.dart';

class AddQuickNote{
  final TodoManagerRepository repository;

  AddQuickNote(this.repository);

  void call({@required String uid, @required Map<String, dynamic> quickNoteData}){
    repository.addQuickNote(
      uid: uid,
      quickNoteData: quickNoteData
    );
  }

}