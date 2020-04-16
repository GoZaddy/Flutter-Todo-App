import 'package:flutter/material.dart';
import 'package:todo_app/models/ListTodo.dart';
import 'package:todo_app/models/TodoList.dart';
import 'package:todo_app/widgets/ListTodoWidget.dart';




class ListWidget extends StatelessWidget {
  TodoList todoList;
  ListWidget( TodoList todoList){
    this.todoList = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
      padding: EdgeInsets.only(left:30.0, right: 50.0, top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: todoList.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            
            color: todoList.backgroundColor,
            offset: Offset(0, 0),
            blurRadius: 3,
            spreadRadius: 0

          )
        ]

        ,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                todoList.listTitle,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
            color: Colors.white,
          ),
          Expanded(
            
            child: Container(
              child: Column(
                children:todoList.listOfTodos.sublist(0,4).map((listTodo){
                  return ListTodoWidget(listTodo);
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}