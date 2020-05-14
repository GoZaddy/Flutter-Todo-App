part of 'add_quick_note_bloc.dart';

abstract class AddQuickNoteEvent extends Equatable {
  final List properties;
  const AddQuickNoteEvent([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [properties];

}


class AddQuickNote extends AddQuickNoteEvent{
  final Map<String, dynamic> quickNoteData;

  AddQuickNote(this.quickNoteData);
}


