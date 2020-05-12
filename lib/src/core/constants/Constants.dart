import 'package:flutter/material.dart';

const List<Color> listOfColorsForColorPicker = [
    Color(0xff878CAC),
    Color(0xff4F5578),
    Color(0xff657AFF),
    Color(0xff3AB9F2),
    Color(0xff63D2BF),
    Color(0xffEB70B1)
  ];

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String colorToHex(Color color){
  return "#${color.toString().substring(10,16)}";
}



