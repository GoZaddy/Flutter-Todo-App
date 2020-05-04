import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/UI/widgets/all_lists.dart';
import 'package:todo_app/src/UI/widgets/all_quick_notes.dart';
import 'package:todo_app/src/blocs/dashboard_bloc.dart';
import 'package:todo_app/src/models/User.dart';
import 'package:todo_app/src/resources/auth_service.dart';
import 'package:todo_app/src/UI/widgets/ListBottomSheet.dart';
import 'package:todo_app/src/UI/widgets/MenuIcon.dart';
import 'package:todo_app/src/models/TodoList.dart';
import 'package:todo_app/src/UI/widgets/SmallButton.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final DashboardBloc bloc;
  DashboardScreen({
    this.bloc
  });
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Dashboard(
          bloc:bloc,
          user: currentUser,
          scaffoldKey: _scaffoldKey
        ),
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
                            onPressed: () async {
                              print(Navigator);
                              //Navigator.pop(context);
                              await Navigator.popAndPushNamed(context, "/addQuickNote");
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
                            onPressed: () async {
                              
                              await Navigator.popAndPushNamed(context, "/addList");
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
                            onPressed: () async {
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
   final GlobalKey<ScaffoldState> scaffoldKey;
   final User user;
   final DashboardBloc bloc;
  Dashboard({
    this.bloc,
    this.scaffoldKey,
    this.user
  });

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PersistentBottomSheetController _controller;
  TodoList _currentTodoList;
  
  @override
  void initState() {
    
    super.initState();
    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     
     widget.bloc.currentlyShownList.listen((data){
      _currentTodoList = data;
    });
    
   
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  void _showBottomSheet() {
    _controller =
        this.widget.scaffoldKey.currentState.showBottomSheet((context) {
          return ListBottomSheet(
            todoList: _currentTodoList,
            closeBottomSheet: _closeBottomSheet,
          );
        }
      );
    }
  

  void _closeBottomSheet() {
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
   
    if(_currentTodoList == null){
      print("I am null ooo");
    }
    else{
      print(_currentTodoList.listTitle);
    }
    
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
        AllQuickNotes(allQuickNotesStream: widget.bloc.fetchQuickNotes(widget.user.uid)),
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
          allListsStream: widget.bloc.fetchLists(widget.user.uid),
          dashboardBloc: widget.bloc,
          showBottomSheet: _showBottomSheet
        )
      ],
    );
  }
}
