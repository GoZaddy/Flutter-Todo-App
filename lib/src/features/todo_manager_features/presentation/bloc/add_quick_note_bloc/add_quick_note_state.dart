part of 'add_quick_note_bloc.dart';

abstract class AddQuickNoteState extends Equatable {
  final List properties;
  const AddQuickNoteState([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class AddQuickNoteInitial extends AddQuickNoteState {
 
}

class QuickNoteAdded extends AddQuickNoteState{
  
}

class Error extends AddQuickNoteState{
  final String message;

  Error(this.message);
}
