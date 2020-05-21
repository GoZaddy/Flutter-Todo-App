import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/core/user/user.dart';
import 'package:todo_app/src/features/todo_manager_features/data/models/ListTodoModel.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/entities/List.dart';
import 'package:todo_app/src/features/todo_manager_features/domain/usecases/edit_list.dart';

import '../../../../injection_container.dart';
import 'list_todo_widget.dart';

class ListWidget extends StatelessWidget {
  final Key key;
  final ListEntity todoList;
  final VoidCallback onTap;

  ListWidget(
      {@required this.key, @required this.todoList, @required this.onTap})
      : super(key: key);

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
            height: 450,
            width: 250.0,
            decoration: BoxDecoration(
                color: todoList.backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: todoList.backgroundColor,
                      offset: Offset(0, 0),
                      blurRadius: 3,
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35.0),
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0))),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          //color: Colors.red,
                          child: Text(
                            todoList.listTitle,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 250,
                    color: Color(0x33ffffff),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 10.0, bottom: 20.0),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: todoList.listOfTodosStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int _length = snapshot.data.documents.length;
                              return Column(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: snapshot.data.documents
                                        .take(6)
                                        .map((todo) {
                                      return ListTodoWidget(
                                        todo: ListTodoModel.fromFirestoreInfo(
                                            listId: todoList.listId,
                                            todoDoc: todo),
                                        showDetails: false,
                                      );
                                    }).toList(),
                                  ),
                                  _length > 4
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "...",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30.0,
                                                  fontFamily: "Poppins",
                                                  letterSpacing: 10),
                                            ),
                                          ],
                                        )
                                      : SizedBox(height: 0)
                                ],
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator()
                                  ),
                                ],
                              );
                            }
                            return SizedBox(height: 0);
                          }),
                      /**/
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        /*Positioned(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              onTap: onTap,
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete this list"),
                        content:
                            Text("Are you sure you want to delete this list?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("YES"),
                            onPressed: () {
                              Navigator.pop(context);

                              sl<DeleteList>().call(
                                  uid: sl<User>().uid, listId: todoList.listId);
                            },
                          ),
                          FlatButton(
                            child: Text("NO"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                height: 600,
                width: 250.0,
                //color: Colors.purple,
              ),
            ),
          ),
        ),*/
      ],
    );
  }
}
