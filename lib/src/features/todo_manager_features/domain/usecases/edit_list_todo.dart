import 'package:todo_app/src/features/todo_manager_features/domain/repositories/todo_manager_repository.dart';
import 'package:meta/meta.dart';
class SetListTodoIsDone{
  final TodoManagerRepository repository;

  SetListTodoIsDone(this.repository);

  void call({@required String uid,@required String listId,@required String todoId,@required bool isDone}){
    repository.setListTodoIsDone(
      uid: uid,
      isDone: isDone,
      listId: listId,
      todoId: todoId
    );
  }
}