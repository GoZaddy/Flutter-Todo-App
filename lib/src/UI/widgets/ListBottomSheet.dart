import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/blocs/dashboard_bloc.dart';
import 'package:todo_app/src/constants/Constants.dart';
import 'package:todo_app/src/models/ListTodo.dart';
import 'package:todo_app/src/models/TodoList.dart';
import 'package:todo_app/src/models/User.dart';
import 'package:todo_app/src/UI/widgets/ColorPickerButton.dart';
import 'package:todo_app/src/UI/widgets/ListTodoWidget.dart';
import 'package:todo_app/src/resources/repository.dart';

class ListBottomSheet extends StatefulWidget {
  final PersistentBottomSheetController controller;
  final TodoList todoList;
  final VoidCallback closeBottomSheet;

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
  TextEditingController _todoTitleController = new TextEditingController();
  TextEditingController _newTodoController = new TextEditingController();
 
  FocusNode _focusNode = new FocusNode();
 
  
  
  @override
  void initState() {
    super.initState();
     
    setState(() {
      _todoTitleController.text = widget.todoList.listTitle;
      
    });

  }

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _todoTitleController.dispose();
    _focusNode.dispose();
    
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    
    final User _currentUser = Provider.of<User>(context);
    final Repository _repository = new Repository();
    
    print(widget.todoList.listOfTodos.toString());
    return Container(
      padding: EdgeInsets.only(left: 40, right:40, top: 15, bottom: 35),
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.todoList.backgroundColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(50))
      ),
      child: ListView(
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
                onPressed: widget.closeBottomSheet,
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _inEditingMode == true? Colors.blue[400]: Color(0x80FFFFFF)
                )
              )
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    
                    focusNode: _focusNode,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 25.0
                    ),
                    controller: _todoTitleController,
                    decoration: InputDecoration(
                      
                      border: InputBorder.none,
                      hintText: "List title",
                      hintStyle: TextStyle(
                        color: Color(0x80ffffff)
                      )
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                IconButton(
                  icon: Icon(
                    _inEditingMode? Icons.check: Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: (){    
                     setState(() {                                             
                       _inEditingMode = !_inEditingMode;                   
                    });
                    if(_inEditingMode == true){
                      _focusNode.requestFocus();
                    }
                    else{
                      _repository.updateListTitle(
                        uid: _currentUser.uid,
                        listId: widget.todoList.listId,
                        newTitle: _todoTitleController.text
                      );
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0
          ),
          _inEditingMode ? Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: listOfColorsForColorPicker.map(
                      (color){
                        return ColorPickerButton(
                          isSelectedColor: widget.todoList.backgroundColor == color,
                          color: color,
                          onTap: (){
                            _repository.setBackgroundColor(
                              uid: _currentUser.uid,
                              listId: widget.todoList.listId,
                              newColor: color
                            ); 
                            setState((){});             
                          },
                        );
                      }
                    ).toList(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Delete this list"),
                            content: Text("Are you sure you want to delete this list?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("YES"),
                                onPressed: (){
                                  Navigator.pop(context);
                                  widget.closeBottomSheet();
                                  _repository.deleteList(uid:_currentUser.uid, listId: widget.todoList.listId);
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
                        }
                      );
                    },
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0x80ffffff)
              )
            ],
          ): SizedBox(height: 0.0),
          SizedBox(height: 30.0),
          StreamBuilder<QuerySnapshot>(
            stream: _repository.getListTodos(uid: _currentUser.uid, listId: widget.todoList.listId),
            builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()
                    ),
                  ],
                );
              }
              if(snapshot.hasData){
                return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.data.documents.map<Widget>(
                  (todo){
                    return Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      width: double.infinity,
                      child: ListTodoWidget(
                        enableAddingDetails: _inEditingMode,
                        checkboxAndTextSpace: 30.0,
                        todo: new ListTodo(isDone: todo["isDone"], title: todo["title"], details: todo["details"], todoId: todo.documentID, listId: widget.todoList.listId),
                        showDetails: true
                      ),
                    );
                  }
                ).toList()
              );
              } 
            }
          ),
          /* */
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  _repository.addNewTodo(
                    uid: _currentUser.uid,
                    todoTitle: _newTodoController.text,
                    listId: widget.todoList.listId
                  );
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
                      color: widget.todoList.backgroundColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.0
              ),
              Expanded(
                child: TextField(
                  controller: _newTodoController,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Poppins",
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add a new todo"
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}