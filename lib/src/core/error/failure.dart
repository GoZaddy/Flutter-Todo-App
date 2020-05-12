import 'package:equatable/equatable.dart';


abstract class Failure extends Equatable{
  final List properties; 
  Failure([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];
}



class AuthFailure extends Failure{}

class NoNetworkFailure extends Failure{}

class FetchQuickNotesFailure extends Failure{}

class FetchListsFailure extends Failure{}

class GetListTodosFailure extends Failure{}