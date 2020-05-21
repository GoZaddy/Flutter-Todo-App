import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/repositories/todo_manager_repository.dart';

import '../../../../core/constants/Constants.dart';
import '../../../../core/user/user.dart';
import '../../../../injection_container.dart';
import '../../data/models/ListTodoModel.dart';
import '../../domain/entities/List.dart';
import '../../domain/usecases/dashboard_use_cases.dart';
import '../../domain/usecases/edit_list.dart';
import 'color_picker_button.dart';
import 'list_todo_widget.dart';

class ListBottomSheet extends StatefulWidget {
  final ListEntity todoList;
  final VoidCallback closeBottomSheet;
  final PersistentBottomSheetController controller;

  ListBottomSheet({
    this.todoList,
    this.closeBottomSheet,
    this.controller
  });

  @override
  _ListBottomSheetState createState() => _ListBottomSheetState();
}

class _ListBottomSheetState extends State<ListBottomSheet> {
  bool _inEditingMode = false;
  final TextEditingController _todoTitleController = new TextEditingController();
  final TextEditingController _newTodoController = new TextEditingController();

  Color _temporaryColor;

  @override
  void initState() {
    super.initState();
    _temporaryColor = widget.todoList.backgroundColor;

    _todoTitleController.text = widget.todoList.listTitle;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _todoTitleController.dispose();
    _newTodoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 30),
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      decoration: BoxDecoration(
          color: _temporaryColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    //Navigator.pop(context);
                    widget.closeBottomSheet();
                  }
              )
            ],
          ),
          Expanded(
                      child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: _inEditingMode == true
                                  ? Colors.blue[400]
                                  : Color(0x80FFFFFF)))),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          enabled: _inEditingMode,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 25.0),
                          controller: _todoTitleController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "List title",
                              hintStyle: TextStyle(color: Color(0x80ffffff))),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      IconButton(
                        icon: Icon(
                          _inEditingMode ? Icons.check : Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          
                          widget.controller.setState(() {
                            _inEditingMode = !_inEditingMode;
                          });
                          if (_inEditingMode == false) {
                            print("Not in editing mode");
                            sl<EditListTitle>().call(
                                uid: sl<User>().uid,
                                listId: widget.todoList.listId,
                                newTitle: _todoTitleController.text);
                            sl<EditBackgroundColor>()(
                                uid: sl<User>().uid,
                                listId: widget.todoList.listId,
                                newColor: _temporaryColor);
                          }
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                _inEditingMode
                    ? Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: listOfColorsForColorPicker.map((color) {
                                  return ColorPickerButton(
                                    isSelectedColor: _temporaryColor == color,
                                    color: color,
                                    onTap: () {
                                      widget.controller.setState(() {
                                        _temporaryColor = color;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Delete this list"),
                                          content: Text(
                                              "Are you sure you want to delete this list?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("YES"),
                                              onPressed: () {
                                                Navigator.pop(context);

                                                widget.closeBottomSheet();

                                                sl<DeleteList>().call(
                                                    uid: sl<User>().uid,
                                                    listId:
                                                        widget.todoList.listId);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("NO"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                              )
                            ],
                          ),
                          Container(
                              width: double.infinity,
                              height: 1,
                              color: Color(0x80ffffff))
                        ],
                      )
                    : SizedBox(height: 0.0),
                SizedBox(height: 20.0),
                StreamBuilder<QuerySnapshot>(
                    stream: sl<FetchListTodos>().call(
                        uid: sl<User>().uid, listId: widget.todoList.listId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator()),
                          ],
                        );
                      }
                      if (snapshot.hasData) {
                        return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  snapshot.data.documents.map<Widget>((todo) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 5.0),
                                  width: double.infinity,
                                  child: ListTodoWidget(
                                      enableAddingDetails: _inEditingMode,
                                      checkboxAndTextSpace: 30.0,
                                      todo: ListTodoModel.fromFirestoreInfo(
                                          listId: widget.todoList.listId,
                                          todoDoc: todo),
                                      showDetails: true),
                                );
                              }).toList()),
                        );
                      }
                    }),
                /* */
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        sl<AddListTodo>()(
                            uid: sl<User>().uid,
                            todoTitle: _newTodoController.text,
                            listId: widget.todoList.listId);
                        _newTodoController.text = "";
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: _temporaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30.0),
                    Expanded(
                      child: TextField(
                        controller: _newTodoController,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Poppins",
                            color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Add a new todo"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
