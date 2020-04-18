import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/QuickNote.dart';
import 'package:todo_app/models/User.dart';
import 'package:todo_app/services/AuthService.dart';
import 'package:todo_app/widgets/ListBottomSheet.dart';
import 'package:todo_app/widgets/ListTodoWidget.dart';
import 'package:todo_app/widgets/ListWidget.dart';
import 'package:todo_app/widgets/MenuIcon.dart';
import 'package:todo_app/widgets/QuickNoteWidget.dart';

import 'package:todo_app/models/ListTodo.dart';
import 'package:todo_app/models/TodoList.dart';
import 'package:todo_app/widgets/SmallButton.dart';


List<ListTodo> _aListofListTodos = [
  ListTodo(title: "3 sets push-ups", isDone: false, details: "Alternate exercises in different variations, 3 sets, 10 reps each with a 1 minute break."),
  ListTodo(title: "3 sets push-ups", isDone: false, details: ""),
  ListTodo(title: "3 sets push-ups", isDone: true, details: ""),
  ListTodo(title: "3 sets push-ups", isDone: false, details: ""),
  ListTodo(title: "3 sets push-ups", isDone: true, details: ""),
  ListTodo(title: "3 sets push-ups", isDone: false, details: "")
];

TodoList _todoList = TodoList(
  backgroundColor: Color(0xff657AFF),
  listTitle: "Workout",
  listOfTodos: _aListofListTodos
);

TodoList _todoList2 = TodoList(
  backgroundColor: Color(0xff4F5578),
  listTitle: "Shopping",
  listOfTodos: _aListofListTodos
);

TodoList _todoList3 = TodoList(
  backgroundColor: Color(0xff3AB9F2),
  listTitle: "Workout",
  listOfTodos: _aListofListTodos
);



class DashboardScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    AuthService authService = Provider.of<AuthService>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: currentUser.exists ?
          Dashboard(currentUser, _scaffoldKey)
              :
          Center(child: CircularProgressIndicator()), 
          endDrawer: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Drawer(
              elevation: 0.0,
              
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SmallButton(
                          color: Color(0xff878CAC),
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                        ),
                        
                        SizedBox(height: 30.0),
                        Row(
                          children: <Widget>[
                            Text(
                              "+ Add a quick note",
                              style:TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 30.0
                            ),
                            SmallButton(
                              icon: Transform.rotate(
                                angle: 45.0,
                                child:Icon(
                                  Icons.attach_file,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.pushNamed(context, "/addQuickNote");
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          children: <Widget>[
                            Text(
                              "+ Add a list",
                              style:TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 30.0
                            ),
                            SmallButton(
                              icon: Icon(
                                Icons.insert_drive_file,
                                color: Colors.white,
                              ),
                              onPressed: (){},
                            )
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          children: <Widget>[
                            Text(
                              "Sign out",
                              style:TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 30.0
                            ),
                            SmallButton(
                              color: Color(0xff878CAC),
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              onPressed: (){
                                authService.signOut();
                                Navigator.pop(context);
                                Navigator.popAndPushNamed(context, "/");   
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ), 
      ),
    );
  }
}


class Dashboard extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  dynamic user;
  TodoList _currentTodoList;
  PersistentBottomSheetController _controller;
  StreamController<TodoList> _currentTodoListController;

  Dashboard(dynamic user, GlobalKey<ScaffoldState> scaffoldKey){
    this.user = user;
    this.scaffoldKey = scaffoldKey;

    _currentTodoListController.stream.listen(
      (TodoList todo){
      _currentTodoList = todo;
  });
  }
  
  void _showBottomSheet(){
    _controller = this.scaffoldKey.currentState.showBottomSheet((context){
      return ListBottomSheet(
        controller: _controller,
        todoList: _currentTodoList,
        closeBottomSheet: _closeBottomSheet,
      );
    });
  }

  void _closeBottomSheet(){
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0, bottom: 20.0),
      shrinkWrap: true,
      children: <Widget>[
        AppBar(
          leading: MenuIcon(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        //SizedBox(height:10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Hello ${this.user.displayName}',
              style: TextStyle(
                fontSize: 32.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w200,
                color: Theme.of(context).accentColor
              ),
            ),
            SmallButton(
              icon: Icon(
                  Icons.add,
                  color: Colors.white,
              ),
              onPressed: (){
                this.scaffoldKey.currentState.openEndDrawer();
              },
            )
          ],
        ),
        SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Quick notes",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: Theme.of(context).accentColor
              ),
            )
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          
          child: ListView(
            
            shrinkWrap: true,
             padding:EdgeInsets.all(0) ,
             children: <Widget>[
               QuickNoteWidget(
                 QuickNote(priority: 1, isDone: false, title: "Make a doctors' appointment ")
               ),
               QuickNoteWidget(
                 QuickNote(priority: 1, isDone: false, title: "Make a doctors' appointment ")
               ),
               QuickNoteWidget(
                 QuickNote(priority: 1, isDone: false, title: "Make a doctors' appointment ")
               ),
               QuickNoteWidget(
                 QuickNote(priority: 1, isDone: false, title: "Make a doctors' appointment ")
               ),
               QuickNoteWidget(
                 QuickNote(priority: 1, isDone: false, title: "Make a doctors' appointment ")
               ),
               QuickNoteWidget(
                 QuickNote(priority: 1, isDone: false, title: "Make a doctors' appointment ")
               )
             ],
           ),
        ),
        SizedBox(
          height: 70.0
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Lists",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: Theme.of(context).accentColor
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0
        ),
        Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 400.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ListWidget(
                      todoList: _todoList,
                      onTap: (){
                        _currentTodoListController.sink.add(_todoList);
                        _showBottomSheet();
                      },
                    ),
                    ListWidget(
                      todoList: _todoList2,
                      onTap: (){
                        _currentTodoListController.sink.add(_todoList2);
                        _showBottomSheet();
                      },
                    ),
                    ListWidget(
                      todoList: _todoList3,
                      onTap: (){
                        _currentTodoListController.sink.add(_todoList3);
                        _showBottomSheet();
                      },
                    ),
                    ListWidget(
                      todoList: _todoList,
                      onTap: (){
                        _currentTodoListController.sink.add(_todoList);
                        _showBottomSheet();
                      },
                    )
                  ],
                )
              ]
            ),
        )
      ]   
    );
  }
  
}

class _DashboardState extends State<Dashboard> {
  
}