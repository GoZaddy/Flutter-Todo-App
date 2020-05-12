import 'package:flutter/material.dart';

import '../../../../core/priority/Priority.dart';

class QuickNote{
  String quickNoteId;
  Priority priority;
  bool isDone;
  String title;


  QuickNote({
    @required this.priority,
    @required this.isDone,
    @required this.title,
    @required this.quickNoteId
  });

  
}