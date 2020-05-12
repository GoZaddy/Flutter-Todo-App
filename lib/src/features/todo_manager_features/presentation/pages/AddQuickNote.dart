import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_words/random_words.dart';
import 'package:todo_app/src/core/priority/Priority.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/bloc/add_quick_note_bloc/add_quick_note_bloc.dart'
    as bloc;
import 'package:todo_app/src/features/todo_manager_features/presentation/bloc/add_quick_note_bloc/add_quick_note_bloc.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/widgets/select_priority_button.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/widgets/small_button.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/widgets/suggestion_tile.dart';

class AddQuickNote extends StatefulWidget {
  

  
  @override
  _AddQuickNoteState createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  String _quickNoteTitle;
  StreamController<String> _suggestionsTextController =
      new StreamController<String>();
  Priority _quickNotePriority = Priority.fromPriorityValue(3);
  final List<int> _priorityValues = [1, 2, 3];
  int _selectedPriorityValue = 3;

  final TextEditingController _textController = new TextEditingController();

  final Iterable<String> _suggestions = [
    ...adjectives.take(5),
    ...nouns.take(10)
  ];

  @override
  void initState() {
    super.initState();
    _suggestionsTextController.stream.listen((String suggestion) {
      _textController.value = _textController.value
          .copyWith(text: _textController.text + suggestion);
    });
  }

  @override
  void dispose() {
    _suggestionsTextController.close();
    _textController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _textInputFocusNode = new FocusNode();

    _textController.addListener(() {
      _quickNoteTitle = _textController.text;
    });
    return BlocListener<bloc.AddQuickNoteBloc, bloc.AddQuickNoteState>(
      listener: (context, state) {
        if (state is bloc.QuickNoteAdded) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("New Quick note added"),
                );
              }).then((value) {
            _suggestionsTextController.sink.add("");
            _quickNoteTitle = "";
            _textController.text = "";
            setState(() {
              _selectedPriorityValue = 3;
            });
            _quickNotePriority = Priority.fromPriorityValue(3);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 10.0, right: 20.0),
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      color: Colors.yellow,
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.clear,
                          size: 26.0, color: Color(0xff616B77)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 10.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          focusNode: _textInputFocusNode,
                          controller: _textController,
                          style: TextStyle(
                              fontSize: 27.0,
                              fontFamily: "Poppins",
                              color: Theme.of(context).accentColor),
                          decoration: InputDecoration(
                            hintText: "Write your quick note",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      SmallButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          BlocProvider.of<AddQuickNoteBloc>(context).add(bloc.AddQuickNote({
                            "priority": _quickNotePriority.priorityValue,
                            "title": _quickNoteTitle,
                            "isDone": false
                          }));
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: <Widget>[
                      Text(
                        "Suggestions",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).accentColor),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: _suggestions.map((word) {
                        return SuggestionTile(
                          title: word.toString(),
                          onTap: () {
                            _suggestionsTextController.sink.add(word);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: <Widget>[
                      Text(
                        "Priority",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).accentColor),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _priorityValues.map((priority) {
                      return SelectPriorityButton(
                          priority: Priority.fromPriorityValue(priority),
                          onPressed: () {
                            setState(() {
                              _quickNotePriority =
                                  Priority.fromPriorityValue(priority);

                              _selectedPriorityValue = priority;
                            });
                          },
                          isSelected: _selectedPriorityValue == priority);
                    }).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
