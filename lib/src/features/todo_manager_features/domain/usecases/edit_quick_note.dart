import 'package:todo_app/src/features/todo_manager_features/domain/repositories/todo_manager_repository.dart';
import 'package:meta/meta.dart';
class EditQuickNoteTitle {
  final TodoManagerRepository repository;

  EditQuickNoteTitle(this.repository);

  void call({@required String uid,@required String quickNoteId,@required String newTitle}){
    repository.setQuickNoteTitle(
      uid: uid,
      quickNoteId: quickNoteId,
      newTitle: newTitle
    );
  }
}

class DeleteQuickNote {
  final TodoManagerRepository repository;

  DeleteQuickNote(this.repository);

  void call({@required String uid,@required String quickNoteId}){
    repository.deleteQuickNote(
      uid: uid,
      quickNoteId: quickNoteId,
    );
  }
}

class SetQuickNoteIsDone {
  final TodoManagerRepository repository;

  SetQuickNoteIsDone(this.repository);

  void call({@required String uid,@required String quickNoteId,@required bool isDone}){
    repository.setQuickNoteIsDone(
      uid: uid,
      quickNoteId: quickNoteId,
      isDone: isDone
    );
  }
}
