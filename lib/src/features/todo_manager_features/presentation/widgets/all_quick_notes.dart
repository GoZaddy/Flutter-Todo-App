import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/features/todo_manager_features/data/models/QuickNoteModel.dart';


import 'no_widget.dart';
import 'quick_note_widget.dart';

class AllQuickNotes extends StatelessWidget {
  final Stream allQuickNotesStream;

  AllQuickNotes({@required this.allQuickNotesStream});

  @override
  Widget build(BuildContext context) {
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
                      return QuickNoteWidget(key: UniqueKey(), quickNoteInfo: QuickNoteModel.fromFirestoreDoc(document));
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
