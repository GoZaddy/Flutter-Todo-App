import 'package:flutter/material.dart';
import 'package:todo_app/UI/views/base_view.dart';
import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/models/ListTodo.dart';
import 'package:todo_app/core/models/TodoList.dart';
import 'package:todo_app/UI/widgets/ListTodoWidget.dart';
import 'package:todo_app/core/viewmodels/list_widget_model.dart';

class ListWidget extends StatelessWidget {
  final TodoList todoList;
  final VoidCallback onTap;

  ListWidget({this.todoList, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseView<ListModel>(
      builder: (context, model, child) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
          height: 600,
          width: 250.0,
          decoration: BoxDecoration(
              color: todoList.backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: todoList.backgroundColor,
                    offset: Offset(0, 0),
                    blurRadius: 3,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0))),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 50.0, top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Text(
                          todoList.listTitle,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: 250,
                  color: Color(0x33ffffff),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 50.0, top: 10.0, bottom: 20.0),
                      child: model.state == ViewState.Busy
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(),
                                )
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: model.todos.take(4).map((todo) {
                                    return ListTodoWidget(
                                      todo: new ListTodo(
                                          isDone: todo["isDone"],
                                          title: todo["title"],
                                          details: todo["details"],
                                          todoPath: todo.reference),
                                      showDetails: false,
                                    );
                                  }).toList(),
                                ),
                                model.todos.length > 4
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "...",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30.0,
                                                fontFamily: "Poppins",
                                                letterSpacing: 10),
                                          ),
                                        ],
                                      )
                                    : SizedBox(height: 0)
                              ],
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
