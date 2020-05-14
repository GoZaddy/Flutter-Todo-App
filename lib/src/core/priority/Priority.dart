import 'package:flutter/material.dart';
class Priority{
  String importance;
  int priorityValue;
  Color color;

  Priority.fromPriorityValue(int value){
    if (value == 1){
      this.priorityValue = value;
      this.color = Color(0xffFF4A4A);
      this.importance = "High";
    } 
    else if(value == 2){
      this.priorityValue = value;
      this.color =  Color(0xffF3C018);
      this.importance = "Low";
    }
    else{
      this.priorityValue = 3;
      this.color = Color(0xff878CAC);
      this.importance = "None";
    }
  }

}