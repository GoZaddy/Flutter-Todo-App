part of 'add_list_bloc.dart';

abstract class AddListEvent extends Equatable {
  final List properties;
  const AddListEvent([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class AddList extends AddListEvent {
  final String listTitle;
  final List<ListTodo> listOfTodos;
  final String listBackgroundColor;
  AddList({
    @required this.listTitle,
    @required this.listOfTodos,
    @required this.listBackgroundColor
  });
}
