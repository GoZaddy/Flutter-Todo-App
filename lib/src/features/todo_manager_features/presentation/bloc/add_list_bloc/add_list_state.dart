part of 'add_list_bloc.dart';


abstract class AddListState extends Equatable {
  final List properties;
  const AddListState([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class AddListInitial extends AddListState {
 
}
class AddingList extends AddListState{

}
class ListAdded extends AddListState{

}

class Error extends AddListState{
  final String message;

  Error(this.message);
}
