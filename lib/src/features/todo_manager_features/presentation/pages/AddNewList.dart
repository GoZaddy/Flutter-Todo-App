
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/bloc/add_list_bloc/add_list_bloc.dart'
    as event;

import '../../../../core/constants/Constants.dart';
import '../../domain/entities/ListTodo.dart';
import '../bloc/add_list_bloc/add_list_bloc.dart';
import '../widgets/small_button.dart';

class AddList extends StatefulWidget {
  
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  Color _selectedColor = listOfColorsForColorPicker[2];
  List<ListTodo> _listOfTodos = [];

  final TextEditingController _newTodoController = new TextEditingController();
  final TextEditingController _titleController = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return BlocListener<AddListBloc, AddListState>(
      listener: (context, state) {
        if (state is AddingList) {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                });
          }
        } else if (state is ListAdded) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("New List added"),
                );
              });
          setState(() {
            _titleController.text = "";
            _listOfTodos.clear();
          });
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(children: <Widget>[
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
                        Navigator.pop(context);
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
                child: Column(children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _titleController,
                            validator: (val){
                              if (val.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
  
                            style: TextStyle(
                                fontSize: 27.0,
                                fontFamily: "Poppins",
                                color: Theme.of(context).accentColor),
                            decoration: InputDecoration(
                                hintText: "Title of new list...",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        SmallButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                BlocProvider.of<AddListBloc>(context).add(event.AddList(
                                  listBackgroundColor:
                                      "#${_selectedColor.toString().substring(10, 16)}",
                                  listOfTodos: _listOfTodos,
                                  listTitle: _titleController.text));
                              }
                              
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: listOfColorsForColorPicker.map((Color color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: color,
                            border: color == Color(0xffFFFFFF)
                                ? Border.all(
                                    width: 1,
                                    color: Theme.of(context).accentColor)
                                : Border.all(width: 0, color: color),
                          ),
                          child: Center(
                            child: _selectedColor == color
                                ? Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                : SizedBox(width: 0, height: 0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "List items",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Theme.of(context).accentColor),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  _listOfTodos.length >= 1
                      ? Column(
                          children: _listOfTodos.map((ListTodo todo) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 30.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: _selectedColor),
                                  ),
                                  SizedBox(width: 40.0),
                                  Text(
                                    todo.title,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "Poppins",
                                        color: Theme.of(context).accentColor),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      : SizedBox(height: 0, width: 0),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _listOfTodos.add(new ListTodo(
                                isDone: false,
                                title: _newTodoController.text,
                                details: ""));
                            print(_listOfTodos[0].title);
                            _newTodoController.text = "";
                          });
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Theme.of(context).primaryColor),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Expanded(
                        child: TextField(
                          controller: _newTodoController,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Poppins",
                              color: Theme.of(context).accentColor),
                          decoration: InputDecoration(
                              hintText: "Add new note",
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ],
                  )
                ])),
          ])),
    );
  }
}
