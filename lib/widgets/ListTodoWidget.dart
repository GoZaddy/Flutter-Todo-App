import 'package:flutter/material.dart';
import 'package:todo_app/models/ListTodo.dart';

class ListTodoWidget extends StatefulWidget {
  ListTodo listTodo;

  ListTodoWidget(this.listTodo);
  @override
  _ListTodoWidgetState createState() => _ListTodoWidgetState();
}

class _ListTodoWidgetState extends State<ListTodoWidget> {
  @override
  Widget build(BuildContext context) {
    ListTodo _listTodoPassed = widget.listTodo;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: _listTodoPassed.isDone,
            onChanged: (bool newValue){
              setState(() {
                _listTodoPassed.isDone = newValue;
              });
            },
          ),
          Text(
            _listTodoPassed.title,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                color: Colors.white
            ),
          )
        ],
      )
    );
  }
}