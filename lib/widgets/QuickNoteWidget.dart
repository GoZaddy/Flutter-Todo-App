import 'package:flutter/material.dart';
import 'package:todo_app/models/QuickNote.dart';

class QuickNoteWidget extends StatefulWidget {
  final QuickNote quickNoteInfo;
  QuickNoteWidget(
     this.quickNoteInfo
    );
  @override
  _QuickNoteWidgetState createState() => _QuickNoteWidgetState();
}

class _QuickNoteWidgetState extends State<QuickNoteWidget> {
 
  @override
  Widget build(BuildContext context) {
    
    QuickNote quickNoteInfo = this.widget.quickNoteInfo;

    return Container(
      
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 18,
                height: 18,
                child: Checkbox(
                  
                  value: quickNoteInfo.isDone,
                  activeColor: Color(0x80878CAC),
                  checkColor: Colors.white,
                  onChanged: (bool isChecked){
                    //print(_isDone);
                    setState(() {
                      quickNoteInfo.isDone = isChecked;
                    });
                    //print(_isDone);
                    
                  },
                  
                ),
              ),
              SizedBox(width: 30.0),
              Text(
                quickNoteInfo.title,
                style: TextStyle(
                  fontSize: 18.0,
                  decoration: quickNoteInfo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  color: quickNoteInfo.isDone? Color(0x4D878CAC) :Color(0xff878CAC),
                  fontFamily: "Poppins"
                ),
              )
              
            ],
          ),
          Container(
            height: 7.0,
            width: 7.0,
            decoration: BoxDecoration(
              color: quickNoteInfo.priority.color,
              borderRadius: BorderRadius.circular(10.0)
            ),
          )
        ],
      ),
    );
  }
}