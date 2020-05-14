import 'package:todo_app/src/features/todo_manager_features/domain/entities/ListTodo.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/repositories/todo_manager_repository.dart';

class AddList{
  final TodoManagerRepository repository;

  AddList(this.repository);

  Future call({@required String uid, @required String listTitle, @required List<ListTodo> listOfTodos, @required String listBackgroundColor}) async{
    await repository.addList(
      uid: uid,
      listBackgroundColor: listBackgroundColor,
      listOfTodos: listOfTodos,
      listTitle: listTitle
    );
  }

}