import 'package:flutter/material.dart';

class LevelDifficultGame extends StatelessWidget {
  final String title;
  final color;

  LevelDifficultGame({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      shape: StadiumBorder(),
      child: Text(title, style: TextStyle(
          fontFamily: 'Quicksand', fontWeight: FontWeight.w600, color: Colors.white),),
      onPressed: () {},
    );
  }
}
