import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/src/blocs/base_bloc.dart';
import 'package:todo_app/src/models/TodoList.dart';
import 'package:todo_app/src/resources/repository.dart';

class DashboardBloc implements BaseBloc{

  final _repository = Repository();

  StreamController<TodoList> _currentlyShownListController = new StreamController<TodoList>.broadcast();

  Function(TodoList) get openList => _currentlyShownListController.sink.add;

  Stream<TodoList> get currentlyShownList => _currentlyShownListController.stream.asBroadcastStream();

  

  Stream<QuerySnapshot> fetchQuickNotes(String uid){
    return _repository.fetchQuickNotes(uid);
  }

  Stream<QuerySnapshot> fetchLists(String uid){
    return _repository.fetchLists(uid);
  }


  @override
  void dispose() {
    
    _currentlyShownListController.close();
  }

}