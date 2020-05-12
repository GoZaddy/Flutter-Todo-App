import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/user/user.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/usecases/add_list.dart'
    as usecase;
import 'package:todo_app/src/features/todo_manager_features/domain/entities/ListTodo.dart';

part 'add_list_event.dart';
part 'add_list_state.dart';

class AddListBloc extends Bloc<AddListEvent, AddListState> {
  final usecase.AddList _addList;
  final User _user;

  AddListBloc({@required usecase.AddList addList, @required User user})
      : assert(addList != null),
        _addList = addList,
        assert(user != null),
        _user = user;
  @override
  AddListState get initialState => AddListInitial();

  @override
  Stream<AddListState> mapEventToState(
    AddListEvent event,
  ) async* {
    if (event is AddList){
      yield AddingList();
      await _addList(
        uid: _user.uid,
        listTitle: event.listTitle,
        listOfTodos: event.listOfTodos,
        listBackgroundColor: event.listBackgroundColor
      );
      yield ListAdded();
    }
  }
}
