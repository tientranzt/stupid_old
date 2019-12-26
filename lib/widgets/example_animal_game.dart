import 'package:flutter/material.dart';


class ExampleAnimalGame extends StatelessWidget {
  final String name;
  final score;
  ExampleAnimalGame({this.name, this.score});
  @override
  Widget build(BuildContext context) {
    return  Row(children: <Widget>[
      Image.asset(
        "assets/images/zodiac/$name.png",
        height: 35,
        width: 35,
        fit: BoxFit.cover,
      ),
      Text(
        '($score)',
        style: TextStyle(fontFamily: 'Quicksand'),
      )
    ],);
  }
}
