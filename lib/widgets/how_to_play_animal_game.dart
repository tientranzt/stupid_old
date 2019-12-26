import 'package:flutter/material.dart';

class HowToPlayAnimalGame extends StatelessWidget {
  final String path;
  final String name;
  final int score;

  HowToPlayAnimalGame({this.path, this.score, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                "assets/images/zodiac/$path.png",
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
              Text(
                name,
                style: TextStyle(fontFamily: 'Quicksand'),
              )
            ],
          ),
          Text(
            score.toString() + 'đ',
            style:
                TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
