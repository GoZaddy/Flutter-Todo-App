import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/QuickNote.dart';
import 'package:todo_app/models/User.dart';
import 'package:todo_app/services/AuthService.dart';
import 'package:todo_app/widgets/ListTodoWidget.dart';
import 'package:todo_app/widgets/ListWidget.dart';
import 'package:todo_app/widgets/MenuIcon.dart';
import 'package:todo_app/widgets/QuickNoteWidget.dart';

import 'package:todo_app/models/ListTodo.dart';
import 'package:todo_app/models/TodoList.dart';


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
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return Scaffold(  
      body: currentUser.exists ?
        Dashboard(user: currentUser)
            :
        Center(child: CircularProgressIndicator())   
    );
  }
}


class Dashboard extends StatelessWidget {
  final dynamic user;
  Dashboard({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
      child: Column(
        
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
                'Hello ${user.displayName}',
                style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w200,
                  color: Theme.of(context).accentColor
                ),
              ),
              Container(
                width: 45.0,
                child: RaisedButton(
                  onPressed: (){},
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                ),
              )
            ],
          ),
          SizedBox(height: 20.0),
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
          SizedBox(height: 15.0),
          Flexible(
            flex: 1,
            child: Container(
             child: ListView(
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
          ),
          SizedBox(
            height: 30.0
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
            height: 20.0
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 300.0,
              width: MediaQuery.of(context).size.width - 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ListWidget(_todoList),
                      ListWidget(_todoList2),
                      ListWidget(_todoList3),
                      ListWidget(_todoList)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
        
      ),
    );
  }
}