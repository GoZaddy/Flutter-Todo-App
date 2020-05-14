part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  final List properties;
  const DashboardEvent([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];

}

class FetchUserData extends DashboardEvent{}



class OpenList extends DashboardEvent{
  final ListEntity listEntity;

  OpenList(this.listEntity): super([listEntity]);
}

class CloseList extends DashboardEvent{}