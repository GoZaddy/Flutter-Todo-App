import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/user/user.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/usecases/add_quick_note.dart' as usecase;


part 'add_quick_note_event.dart';
part 'add_quick_note_state.dart';

class AddQuickNoteBloc extends Bloc<AddQuickNoteEvent, AddQuickNoteState> {
  final usecase.AddQuickNote _addQuickNote;
  final User _user;

  AddQuickNoteBloc({
    @required User user,
    @required usecase.AddQuickNote addQuickNote
  }): assert(user != null), _user  = user,
      assert(addQuickNote != null), _addQuickNote = addQuickNote;

  @override
  AddQuickNoteState get initialState => AddQuickNoteInitial();

  @override
  Stream<AddQuickNoteState> mapEventToState(
    AddQuickNoteEvent event,
  ) async* {
    try{
      if(event is AddQuickNote){
      _addQuickNote(uid: _user.uid, quickNoteData: event.quickNoteData);
      yield QuickNoteAdded();
    }
    }
    catch(e){
      yield Error("Error adding Quick Notes");
      print(e);
    }
    
  }
}
