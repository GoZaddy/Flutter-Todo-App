import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/views/base_view.dart';
import 'package:todo_app/core/models/QuickNote.dart';
import 'package:todo_app/UI/widgets/SmallButton.dart';
import 'package:todo_app/core/viewmodels/quick_note_widget_model.dart';

class QuickNoteWidget extends StatefulWidget {
  final QuickNote quickNoteInfo;
  QuickNoteWidget(this.quickNoteInfo);
  @override
  _QuickNoteWidgetState createState() => _QuickNoteWidgetState();
}


class _QuickNoteWidgetState extends State<QuickNoteWidget> {
  TextEditingController _quickNoteTitleController = new TextEditingController(); 
  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    
    _quickNoteTitleController.dispose();
    super.dispose();
  }

 
  void _showModalToEditTitle({void Function(DocumentReference, String) editTitle}){
    _quickNoteTitleController = TextEditingController(text: widget.quickNoteInfo.title);
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          ),
          child: Container(
           height: 200,
           
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(                      
                        child: TextField(
                          controller: _quickNoteTitleController, 
                          style: TextStyle(
                            fontSize: 18.0,
                            color:  Color(0xff878CAC),
                            fontFamily: "Poppins"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SmallButton(
                      color: Colors.blue,
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        editTitle(widget.quickNoteInfo.documentPath, _quickNoteTitleController.text);
                        Navigator.of(context).pop();
                        
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<QuickNoteModel>(
          builder:(context, model, child) => InkWell(
        onLongPress: (){
          _showModalToEditTitle(editTitle: model.setItemTitle);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: <Widget>[
                  Container(
                    width: 18,
                    height: 18,
                    child: Checkbox(
                      value: widget.quickNoteInfo.isDone,
                      activeColor: Color(0x80878CAC),
                      checkColor: Colors.white,
                      onChanged: (bool isChecked) {
                        setState(() {
                          this.widget.quickNoteInfo.isDone = isChecked;
                        });
                        model.setItemIsDone(widget.quickNoteInfo.documentPath, widget.quickNoteInfo.isDone);
                      },
                    ),
                  ),
                  SizedBox(width: 30.0),
                  Container(
                    
                    width: MediaQuery.of(context).size.width * 0.65,
                   
                    child: Text(
                      widget.quickNoteInfo.title,
                      style: TextStyle(
                          fontSize: 18.0,
                          
                          decoration: widget.quickNoteInfo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: widget.quickNoteInfo.isDone
                              ? Color(0x4D878CAC)
                              : Color(0xff878CAC),
                          fontFamily: "Poppins"),
                    ),
                  ),
                ],
              ),
              widget.quickNoteInfo.isDone
                  ? Container(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          model.delete(widget.quickNoteInfo.documentPath);
                        },
                        child: Icon(
                          Icons.clear,
                          color: Theme.of(context).accentColor,
                          size: 20,
                        ),
                      ),
                    )
                  : Container(
                      height: 7.0,
                      width: 7.0,
                      decoration: BoxDecoration(
                          color: widget.quickNoteInfo.priority.color,
                          borderRadius: BorderRadius.circular(10.0)),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
