import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/UI/widgets/NoWidget.dart';
import 'package:todo_app/src/UI/widgets/QuickNoteWidget.dart';
import 'package:todo_app/src/models/Priority.dart';
import 'package:todo_app/src/models/QuickNote.dart';
import 'package:todo_app/src/models/User.dart';

class AllQuickNotes extends StatelessWidget {
  final Stream allQuickNotesStream;

  AllQuickNotes({@required this.allQuickNotesStream});

  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<User>(context);
    return StreamBuilder(
      stream: allQuickNotesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.documents.length == 0) {
            return Text(
              "No Quick Notes available",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18.0,
                  color: Theme.of(context).accentColor),
            );
          }
          return Column(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: (ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    children: snapshot.data.documents
                        .map<Widget>((DocumentSnapshot document) {
                      return QuickNoteWidget(
                        _user.uid,
                        new QuickNote(
                          priority:
                              Priority.fromPriorityValue(document["priority"]),
                          isDone: document["isDone"],
                          title: document["title"],
                          quickNoteId: document.documentID));
                    }).toList())),
              ),
              SizedBox(height: 30.0),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (CircularProgressIndicator()),
            ],
          );
        }
        return NoWidget();
      },
    );
  }
}
