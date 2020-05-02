import 'package:flutter/material.dart';
import 'package:todo_app/core/models/Priority.dart';

class SelectPriorityButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Priority priority;
  final bool isSelected;

  SelectPriorityButton({
    this.onPressed,
    this.priority,
    this.isSelected
  });
  @override 
  Widget build(BuildContext context) {
    return FlatButton(
      color: isSelected ? Theme.of(context).primaryColor: Color(0xffEFF1F9),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 5,
            width: 5,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: priority.color,
            ),
          ),
          SizedBox(width: 20),
          Text(
            priority.importance,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 17.0,
              color: isSelected? Colors.white : Theme.of(context).accentColor

            ),
          )
        ],
      ),
    );
  }
}