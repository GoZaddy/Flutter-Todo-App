import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/UI/widgets/All_Lists.dart';
import 'package:todo_app/UI/widgets/All_Quick_Notes.dart';
import 'package:todo_app/core/models/Priority.dart';
import 'package:todo_app/core/models/QuickNote.dart';
import 'package:todo_app/core/models/User.dart';
import 'package:todo_app/core/services/AuthService.dart';
import 'package:todo_app/UI/widgets/ListBottomSheet.dart';
import 'package:todo_app/UI/widgets/MenuIcon.dart';
import 'package:todo_app/UI/widgets/QuickNoteWidget.dart';

import 'package:todo_app/core/models/TodoList.dart';
import 'package:todo_app/UI/widgets/SmallButton.dart';



class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<User>(context);
    
    
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Dashboard(currentUser, _scaffoldKey),
        endDrawer: Container(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        children: <Widget>[
                          Text(
                            "+ Add a quick note",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30.0),
                          SmallButton(
                            icon: Transform.rotate(
                              angle: 45.0,
                              child: Icon(
                                Icons.attach_file,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
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
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30.0),
                          SmallButton(
                            icon: Icon(
                              Icons.insert_drive_file,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/addList");
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        children: <Widget>[
                          Text(
                            "Sign out",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30.0),
                          SmallButton(
                            color: Color(0xff878CAC),
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            onPressed: () async{
                              await AuthService().signOut();
                               print(currentUser);
                               
                               Navigator.of(context).pop();
                             
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

class Dashboard extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  User user;

  Dashboard(dynamic user, GlobalKey<ScaffoldState> scaffoldKey) {
    this.user = user;
    this.scaffoldKey = scaffoldKey;
  }

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PersistentBottomSheetController _controller;
  TodoList _currentTodoList;
  StreamController<TodoList> _currentTodoListController =
      new StreamController<TodoList>();

  @override
  void initState() {
    
    super.initState();
    _currentTodoListController.stream.listen((TodoList todo) {
      _currentTodoList = todo;
    });
    
  }

  @override
  void dispose() {
    _currentTodoListController.close();
    super.dispose();
  }

  
  void _showBottomSheet() {
    _controller =
        this.widget.scaffoldKey.currentState.showBottomSheet((context) {
      return ListBottomSheet(
        todoList: this._currentTodoList,
        closeBottomSheet: _closeBottomSheet,
      );
    });
  }

  void _closeBottomSheet() {
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      padding:
        EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0, bottom: 20.0),
      shrinkWrap: true,
      children: <Widget>[
        AppBar(
          leading: MenuIcon(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Hello ${this.widget.user.displayName.toString().split(" ")[0]}',
              style: TextStyle(
                  fontSize: 32.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w200,
                  color: Theme.of(context).accentColor),
            ),
            SmallButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                this.widget.scaffoldKey.currentState.openEndDrawer();
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
                  color: Theme.of(context).accentColor),
            )
          ],
        ),
        SizedBox(height: 20.0),
        AllQuickNotes(
          uid: widget.user.uid
        ),

        SizedBox(height: 70.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Lists",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Theme.of(context).accentColor),
            ),
          ],
        ),
        SizedBox(height: 30.0),

        AllLists(
          uid: widget.user.uid,
          showList: (TodoList todoList){
            _currentTodoListController.sink.add(todoList);
            _showBottomSheet();
          },
        )
      ],
    );
  }
}


