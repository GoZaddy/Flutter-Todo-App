import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/ListModel.dart';
import '../../domain/entities/List.dart';
import 'list_widget.dart';

class AllLists extends StatelessWidget {
  final Stream allListsStream;
  final Function(ListEntity) show;

  AllLists({@required this.allListsStream, @required this.show});
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
              //height: 00.0,
              child: LimitedBox(
                maxHeight: 550.0,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                          children: snapshot.data.documents
                              .map<Widget>((DocumentSnapshot lists) {
                        ListEntity _newTodoList =
                            ListModel.fromFirestoreDoc(lists);

                        return ListWidget(
                          key: UniqueKey(),
                          todoList: _newTodoList,
                          onTap: () {
                            print("tap list");
                            print(_newTodoList.backgroundColor.toString());
                            print(_newTodoList.listTitle);
                            print(_newTodoList.listId);
                            show(_newTodoList);
                            //BlocProvider.of<DashboardBloc>(context).add(OpenList(_newTodoList));
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
