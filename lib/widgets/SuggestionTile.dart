import 'package:flutter/material.dart';

class SuggestionTile extends StatelessWidget {
  
  final String title;
  final VoidCallback onTap; 
  SuggestionTile({
    
    this.title,
    this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.only(right:10, bottom: 10),
      decoration: BoxDecoration(
        color: this.title.length > 5 ? Color(0x4D12B3C5) : Color(0x4D657AFF),
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        
        //splashColor: Colors.red,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            this.title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15.0,
              color: Theme.of(context).accentColor
            ),
          ),
        ),
      ),
    );
  }
}