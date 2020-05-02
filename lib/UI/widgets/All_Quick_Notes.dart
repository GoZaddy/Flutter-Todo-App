import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/views/base_view.dart';
import 'package:todo_app/UI/widgets/NoWidget.dart';
import 'package:todo_app/UI/widgets/QuickNoteWidget.dart';
import 'package:todo_app/core/enums/viewstate.dart';
import 'package:todo_app/core/models/Priority.dart';
import 'package:todo_app/core/models/QuickNote.dart';
import 'package:todo_app/core/viewmodels/all_quick_notes_models.dart';

class AllQuickNotes extends StatelessWidget {
  String uid;

  AllQuickNotes({
    @required this.uid
  });


  @override
  Widget build(BuildContext context) {
    return BaseView<AllQuickNotesModel>(
      onModelReady: (model){
        model.getQuickNotes(uid);
      },
      builder: (context, model, widget) {
        switch (model.state) {
          case ViewState.Busy:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (CircularProgressIndicator()),
              ],
            );
            break;
          case ViewState.Idle:
            if (model.quickNotes.length == 0) {
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
                      children: model.quickNotes
                          .map<Widget>((DocumentSnapshot document) {
                        return QuickNoteWidget(new QuickNote(
                            priority: Priority.fromPriorityValue(
                                document["priority"]),
                            isDone: document["isDone"],
                            title: document["title"],
                            documentPath: document.reference));
                      }).toList())),
                ),
                SizedBox(height: 30.0),
              ],
            );
            break;
          default:
            return NoWidget();
        }
      },
    );
  }
}
