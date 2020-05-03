import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/UI/widgets/ListWidget.dart';
import 'package:todo_app/src/blocs/dashboard_bloc.dart';
import 'package:todo_app/src/constants/Constants.dart';
import 'package:todo_app/src/models/TodoList.dart';

class AllLists extends StatelessWidget {
  final Stream allListsStream;
  final DashboardBloc dashboardBloc;
  final VoidCallback showBottomSheet;

  AllLists({
    @required this.allListsStream,
    @required this.dashboardBloc,
    @required this.showBottomSheet
  });
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
        stream: allListsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.documents.length == 0) {
              return (Row(
                children: <Widget>[
                  Text(
                    "No Lists available",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor),
                  )
                ],
              ));
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
                          children: snapshot.data.documents
                              .map<Widget>((DocumentSnapshot lists) {
                        TodoList _newTodoList = TodoList(
                            listTitle: lists["title"],
                            backgroundColor:
                                hexToColor(lists["backgroundColor"]),
                            listOfTodos: [],
                            listId: lists.documentID,
                            listOfTodosStream: lists.reference
                                .collection("todos")
                                .orderBy("isDone")
                                .snapshots().asBroadcastStream());

                        return ListWidget(
                          todoList: _newTodoList,
                          onTap: () {
                            dashboardBloc.openList(_newTodoList);
                            showBottomSheet();
                            
                          },
                        );
                      }).toList())
                    ]),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              ],
            );
          }
        });
  }
}
