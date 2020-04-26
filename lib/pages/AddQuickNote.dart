import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_words/random_words.dart';
import 'package:todo_app/models/Priority.dart';
import 'package:todo_app/models/User.dart';
import 'package:todo_app/widgets/SelectPriorityButton.dart';
import 'package:todo_app/widgets/SmallButton.dart';
import 'package:todo_app/widgets/SuggestionTile.dart';

class AddQuickNote extends StatefulWidget {
  @override
  _AddQuickNoteState createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  String _quickNoteTitle;
  StreamController<String> _suggestionsTextController = new StreamController<String>();
  Priority _quickNotePriority = Priority.fromPriorityValue(3);
  List<int> _priorityValues = [1,2,3];
  int _selectedPriorityValue = 3;

  TextEditingController _textController =  new TextEditingController();

  Iterable<String> _suggestions = [...adjectives.take(7), ...nouns.take(8)];

  @override
  void initState() {
    super.initState();
    _suggestionsTextController.stream.listen(
      (String suggestion){
        _textController.value = _textController.value.copyWith(text:_textController.text + suggestion);
      }
    );
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
    User currentUser = Provider.of<User>(context);

    _textController.addListener((){
      _quickNoteTitle = _textController.text;
      
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 20.0),
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
                      Navigator.pop(context);
                    },
                    icon:
                        Icon(Icons.clear, size: 26.0, color: Color(0xff616B77)),
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
                            border:InputBorder.none,
                      ),
                    ),
                    ),
                    SizedBox(width:20.0),
                    SmallButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        currentUser.addQuickNote(
                          {
                            "priority": _quickNotePriority.priorityValue,
                            "title": _quickNoteTitle,
                            "isDone": false
                          }
                        );
                          showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text("New Quick note added"),
                              );
                            }
                          ).then((value){
                            _suggestionsTextController.sink.add("");
                            _quickNoteTitle = "";
                            _textController.text = "";
                            setState(() {
                              _selectedPriorityValue = 3;
                            });
                            _quickNotePriority = Priority.fromPriorityValue(3);
                          });
                        
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
                          fontSize: 20.0, color: Theme.of(context).accentColor),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Container(                  
                  child: Wrap( 
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: _suggestions.map(
                      (word){
                        return SuggestionTile(
                          title: word.toString(),                        
                          onTap: (){
                            _suggestionsTextController.sink.add(word);                            
                          },
                        );
                      }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Text(
                      "Priority",
                      style: TextStyle(
                          fontSize: 20.0, color: Theme.of(context).accentColor),
                    )
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _priorityValues.map(
                    (priority){
                      return SelectPriorityButton(
                        priority: Priority.fromPriorityValue(priority),
                        onPressed: (){
                          setState(() {
                            _quickNotePriority = Priority.fromPriorityValue(priority);
                            
                            _selectedPriorityValue = priority;
                          });
                        },
                        isSelected: _selectedPriorityValue == priority
                      );
                    }
                  ).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
