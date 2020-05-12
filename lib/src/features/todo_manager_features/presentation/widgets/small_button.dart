import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final VoidCallback onPressed;
  SmallButton({this.icon, this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      child: RaisedButton(
        onPressed: onPressed,
        child: icon,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: this.color != null ? this.color : Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      ),
    );
  }
}
