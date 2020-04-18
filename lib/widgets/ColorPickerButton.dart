import 'package:flutter/material.dart';

class ColorPickerButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final bool isSelectedColor;

  ColorPickerButton({
    this.onTap,
    this.color,
    this.isSelectedColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:20,
      width: 20,
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: this.color,
        border: this.isSelectedColor?  Border.all(
          width: 5,
          color: Colors.white
        ): Border.all(width:0, color: this.color),
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.red,
      ),
    );
  }
}