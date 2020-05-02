import 'package:flutter/material.dart';
import 'package:todo_app/UI/views/base_view.dart';
import 'package:todo_app/core/models/ListTodo.dart';
import 'package:todo_app/UI/widgets/NoWidget.dart';
import 'package:todo_app/core/viewmodels/list_to_do_model.dart';

class ListTodoWidget extends StatefulWidget {
  final ListTodo todo;
  final bool showDetails;
  final double checkboxAndTextSpace;
  final bool enableAddingDetails;

  ListTodoWidget(
      {this.todo,
      this.showDetails,
      this.checkboxAndTextSpace,
      this.enableAddingDetails = false});
  @override
  _ListTodoWidgetState createState() => _ListTodoWidgetState();
}

class _ListTodoWidgetState extends State<ListTodoWidget> {
  @override
  Widget build(BuildContext context) {
    ListTodo _listTodoPassed = widget.todo;
    
    return BaseView<ListToDoModel>(
      builder: (context, model, child) => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 20.0,
              height: 20.0,
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: _listTodoPassed.isDone,
                activeColor: Color(0x80ffffff),
                onChanged: (bool newValue) {
                  setState(() {
                    _listTodoPassed.isDone = newValue;
                  });
                  model.setIsDone(widget.todo.todoPath, widget.todo.isDone);
                },
              ),
            ),
            SizedBox(
              width: widget.checkboxAndTextSpace != null
                  ? widget.checkboxAndTextSpace
                  : 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        _listTodoPassed.title,
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            decoration: _listTodoPassed.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: _listTodoPassed.isDone
                                ? Color(0x80ffffff)
                                : Colors.white),
                      ),
                    ],
                  ),
                  widget.showDetails && widget.todo.details != ""
                      ? SizedBox(height: 20.0)
                      : SizedBox(height: 0.0),
                  widget.showDetails && widget.todo.details != ""
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.7 - 40,
                          child: Text(
                            widget.todo.details,
                            softWrap: true,
                            style: TextStyle(
                                color: Color(0x80ffffff),
                                fontSize: 15.0,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w200),
                          ),
                        )
                      : NoWidget()
                ],
              ),
            ),
            widget.enableAddingDetails
                ? IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {})
                : NoWidget()
          ],
        ),
      ),
    );
  }
}
