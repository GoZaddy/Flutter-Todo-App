import 'package:flutter/material.dart';
import 'package:todo_app/constants/Constants.dart';
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
  
  @override
  void initState() {
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
        color: widget.todoList.backgroundColor != null ? widget.todoList.backgroundColor : listOfColorsForColorPicker[0],
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
                      border: InputBorder.none,
                      hintText: "List title",
                      hintStyle: TextStyle(
                        color: Color(0x80ffffff)
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
                    children: listOfColorsForColorPicker.map(
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
                    ),
                    onPressed: (){},
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
          StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Column(
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
              );
            }
          ),
          Row(
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: widget.todoList.backgroundColor,
                  ),
                ),
              ),
              SizedBox(
                width: 30.0
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Poppins",
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add a new todo"
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}