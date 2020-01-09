import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final icon;
  final String title;
  final String score;

  CircleIcon({this.icon, this.title,this.score});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CircleAvatar(
        radius: title == 'Độ ngu'? 30 : 18,
        backgroundColor: Color(0xFFcccc00),
        child: Icon(icon, color: Color(0xFF2b906b)),
      ),
      Text(
        score,
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
      Text(
        title,
        style: TextStyle(
            fontFamily: 'Quicksand', fontSize: 12, color: Colors.white),
      ),
    ]);
  }
}
