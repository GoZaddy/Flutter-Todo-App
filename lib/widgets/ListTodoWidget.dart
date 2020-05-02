import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/ListTodo.dart';
import 'package:todo_app/models/User.dart';
import 'package:todo_app/widgets/NoWidget.dart';

class ListTodoWidget extends StatefulWidget {
  ListTodo todo;
  final bool showDetails;
  final double checkboxAndTextSpace;
  final bool enableAddingDetails;

  ListTodoWidget({
    this.todo,
    this.showDetails,
    this.checkboxAndTextSpace,
    this.enableAddingDetails = false
  });
  @override
  _ListTodoWidgetState createState() => _ListTodoWidgetState();
}

class _ListTodoWidgetState extends State<ListTodoWidget> {
  @override
  Widget build(BuildContext context) {
    ListTodo _listTodoPassed = widget.todo;
    User _currentUser = Provider.of<User>(context);
    return Container(
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
              
              
              onChanged: (bool newValue){
                setState(() {
                  _listTodoPassed.isDone = newValue;
                });
                widget.todo.setIsDone(_currentUser.uid);
              },
            ),
          ),
          SizedBox(
            width: widget.checkboxAndTextSpace != null ? widget.checkboxAndTextSpace :  20.0,
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

                            decoration: _listTodoPassed.isDone ? TextDecoration.lineThrough :TextDecoration.none,
                            color: _listTodoPassed.isDone ? Color(0x80ffffff):Colors.white
                        ),
                      ),
                    ],
                  ),
                widget.showDetails && widget.todo.details != "" ? SizedBox(height: 20.0): SizedBox(height: 0.0),
                widget.showDetails && widget.todo.details != "" ? Container(
                  width: MediaQuery.of(context).size.width * 0.7 - 40,
                  child: Text(
                    widget.todo.details,
                    
                    softWrap: true,
                    style: TextStyle(
                      color: Color(0x80ffffff),
                      fontSize: 15.0,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w200
                    ),
                  ),
                ): NoWidget()

              ],
            ),
          ),
          widget.enableAddingDetails ? IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white
            ),
            onPressed: (){
              
            }
          ): NoWidget()
        ],
      ),
    );
  }
}