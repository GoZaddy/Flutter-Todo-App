part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  final List properties;
  const DashboardState([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}


class Error extends DashboardState{
  final String message;

  Error(this.message);
}

class UserDataLoaded extends DashboardState{
  final Stream<QuerySnapshot> quickNotesStream;
  final Stream<QuerySnapshot> listsStream;
  final String userName;

  UserDataLoaded({
    @required this.quickNotesStream,
    @required this.listsStream,
    @required this.userName
  });
}




class ListIsOpened extends DashboardState{
  final ListEntity list;

  ListIsOpened(this.list): super([list]);

}

class ListIsClosed extends DashboardState{

}





