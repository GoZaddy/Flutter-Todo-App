import 'package:flutter/material.dart';
import 'package:todo_app/models/ListTodo.dart';
import 'package:todo_app/models/TodoList.dart';
import 'package:todo_app/widgets/ColorPickerButton.dart';
import 'package:todo_app/widgets/ListTodoWidget.dart';

class ListBottomSheet extends StatefulWidget {
  final PersistentBottomSheetController controller;
  final TodoList todoList;
  final VoidCallback closeBottomSheet;

  ListBottomSheet({
    this.todoList,
    this.closeBottomSheet,
    this.controller
  });

  @override
  _ListBottomSheetState createState() => _ListBottomSheetState();
}

class _ListBottomSheetState extends State<ListBottomSheet> {

  bool _inEditingMode = false;
  TextEditingController _textController = new TextEditingController();
  List<Color> _listOfColorsForColorPicker = [
    Color(0xff878CAC),
    Color(0xff4F5578),
    Color(0xff657AFF),
    Color(0xffFFFFFF),
    Color(0xff3AB9F2),
    Color(0xff63D2BF),
    Color(0xffEB70B1)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _textController.text = widget.todoList.listTitle;
    });

  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.todoList.backgroundColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(50))
      ),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: widget.closeBottomSheet,
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0x80FFFFFF)
                )
              )
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 25.0
                    ),
                    controller: _textController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x80ffffff),
                          width: 2.0
                        )
                      )
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                IconButton(
                  icon: Icon(
                    _inEditingMode? Icons.check: Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    setState(() {
                      _inEditingMode = !_inEditingMode;
                    });
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0
          ),
          _inEditingMode ? Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _listOfColorsForColorPicker.map(
                      (color){
                        return ColorPickerButton(
                          isSelectedColor: widget.todoList.backgroundColor == color,
                          color: color,
                          onTap: (){
                            widget.controller.setState((){
                              widget.todoList.backgroundColor = color;
                            });              
                          },
                        );
                      }
                    ).toList(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0x80ffffff)
              )
            ],
          ): SizedBox(height: 0.0),
          SizedBox(height: 30.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.todoList.listOfTodos.map(
              (todo){
                return Container(
                  
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: ListTodoWidget(
                    checkboxAndTextSpace: 30.0,
                    todo: todo,
                    showDetails: true
                  ),
                );
              }
            ).toList()
          )
          
        ],
      ),
    );
  }
}