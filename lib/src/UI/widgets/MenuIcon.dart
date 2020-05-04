import 'package:flutter/cupertino.dart';

class MenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 3.0,
            width: 20.0,
            
            decoration: BoxDecoration(
              color: Color(0xff616B77),
              borderRadius: BorderRadius.circular(5)
            ),
          ),
          SizedBox(height: 7.0),
          Container(
            height: 3.0,
            width: 10.0,
            decoration: BoxDecoration(
              color: Color(0xff616B77),
              borderRadius: BorderRadius.circular(5)
            ),
          ),
        ]  
      ),
    );
  }
}