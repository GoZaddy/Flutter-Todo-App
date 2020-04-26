import 'package:flutter/material.dart';
import 'package:todo_app/models/QuickNote.dart';
import 'package:todo_app/widgets/NoWidget.dart';

class QuickNoteWidget extends StatefulWidget {
  final QuickNote quickNoteInfo;
  QuickNoteWidget(this.quickNoteInfo);
  @override
  _QuickNoteWidgetState createState() => _QuickNoteWidgetState();
}

class _QuickNoteWidgetState extends State<QuickNoteWidget> {
  TextEditingController _quickNoteTitleController = new TextEditingController();
  FocusNode _quickNoteTitleFocusNode = new FocusNode();
  @override
  void initState() {
    super.initState();
    _quickNoteTitleController.text = widget.quickNoteInfo.title;
  }

  @override
  void dispose() {
    _quickNoteTitleFocusNode.dispose();
    _quickNoteTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuickNote quickNoteInfo = this.widget.quickNoteInfo;

    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
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
                  value: quickNoteInfo.isDone,
                  activeColor: Color(0x80878CAC),
                  checkColor: Colors.white,
                  onChanged: (bool isChecked) {
                    setState(() {
                      this.widget.quickNoteInfo.isDone = isChecked;
                    });
                    quickNoteInfo.setItemIsDone();
                  },
                ),
              ),
              SizedBox(width: 30.0),
              Container(
                
                width: MediaQuery.of(context).size.width * 0.65,
               
                child: TextField(
                  strutStyle: StrutStyle(
                    
                    
                    forceStrutHeight: true

                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  controller: _quickNoteTitleController,
                  enabled: !quickNoteInfo.isDone,
                  focusNode: _quickNoteTitleFocusNode,
                  onEditingComplete: () {
                    quickNoteInfo
                        .setItemTitle(_quickNoteTitleController.text);
                    _quickNoteTitleFocusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    isDense: true,
                    errorMaxLines: 0,
                    helperMaxLines: 0,
                    hintMaxLines: 0,
                    hasFloatingPlaceholder: false,
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                      fontSize: 18.0,
                      
                      decoration: quickNoteInfo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: quickNoteInfo.isDone
                          ? Color(0x4D878CAC)
                          : Color(0xff878CAC),
                      fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
          _quickNoteTitleFocusNode.hasFocus
              ? Container(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () {
                      quickNoteInfo.delete();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.clear,
                        color: Theme.of(context).accentColor,
                        size: 20,
                      ),
                    ),
                  ),
                )
              : Container(
                  height: 7.0,
                  width: 7.0,
                  decoration: BoxDecoration(
                      color: quickNoteInfo.priority.color,
                      borderRadius: BorderRadius.circular(10.0)),
                )
        ],
      ),
    );
  }
}
