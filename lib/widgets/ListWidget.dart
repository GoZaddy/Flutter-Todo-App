import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/ListTodo.dart';
import 'package:todo_app/models/TodoList.dart';
import 'package:todo_app/widgets/ListTodoWidget.dart';




class ListWidget extends StatelessWidget {
  final TodoList todoList;
  final VoidCallback onTap;

  ListWidget({
    this.todoList,
    this.onTap
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
        width: 250.0,
        
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
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:30.0, right: 50.0, top: 20.0, bottom: 20.0),
                child: Row(
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
              ),
              Container(
                height: 1,
                width: 250,
                color: Color(0x33ffffff),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30.0, right: 50.0, top: 10.0, bottom: 20.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: todoList.listOfTodosStream,
                  builder: (context, snapshot) {

                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children:snapshot.data.documents.map((todo){
                        todoList.listOfTodos.add(new ListTodo(isDone: todo["isDone"], title: todo["title"], details: todo["details"]));
                        return ListTodoWidget(
                          todo: new ListTodo(isDone: todo["isDone"], title: todo["title"], details: todo["details"]),
                          showDetails: false,
                        );
                      }).toList(),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}