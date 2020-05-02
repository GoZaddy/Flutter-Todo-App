import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/views/base_view.dart';
import 'package:todo_app/UI/widgets/ListWidget.dart';
import 'package:todo_app/UI/widgets/NoWidget.dart';
import 'package:todo_app/core/constants/Constants.dart';
import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/models/TodoList.dart';
import 'package:todo_app/core/viewmodels/all_lists_model.dart';

class AllLists extends StatelessWidget {

  final Function(TodoList) showList;
  String uid;
  AllLists({
    @required this.showList,
    @required this.uid
  });
  @override
  Widget build(BuildContext context) {
    return BaseView<AllListsModel>(
      onModelReady: (model){
        model.getLists(uid);
      },
      builder: (context, model, widget) {
        switch (model.state) {
          case ViewState.Busy:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              ],
            );
            break;
          case ViewState.Idle:
            if (model.lists.length == 0) {
              return Row(
                children: <Widget>[
                  Text(
                    "No Lists available",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor),
                  )
                ],
              );
            }
            return Container(
              width: MediaQuery.of(context).size.width - 40,
              child: LimitedBox(
                maxHeight: 550.0,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                          children:
                              model.lists.map<Widget>((DocumentSnapshot lists) {
                        TodoList _newTodoList = TodoList(
                          listTitle: lists["title"],
                          backgroundColor: hexToColor(lists["backgroundColor"]),
                          listRef: lists.reference,
                          listTodosPath: lists.reference
                              .collection("todos")
                              .orderBy("isDone")
                              .reference(),
                        );

                        return ListWidget(
                          todoList: _newTodoList,
                          onTap: (){
                            showList(_newTodoList);
                          },
                        );
                      }).toList())
                    ]),
              ),
            );
            break;
          default:
            return NoWidget();
        }
      },
    );
  }
}
