import 'package:flutter/material.dart';
import 'package:test_stupid/pages/play_animal_game.dart';

class LevelDifficultGame extends StatelessWidget {
  final String title;
  final color;
  final int levelDifficult;
  final int scoreOfQuestion;
  final int scoreSubtract;
  final String loginUser;
  final int totalQuestion;

  LevelDifficultGame(
      {this.title,
      this.color,
      this.levelDifficult,
      this.loginUser,
      this.scoreOfQuestion,
      this.scoreSubtract,
      this.totalQuestion});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      shape: StadiumBorder(),
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayAnimalGame(
                      levelDifficultTimer: levelDifficult,
                      loginUser: loginUser,
                      scoreOfQuestion: scoreOfQuestion,
                      scoreSubstract: scoreSubtract,
                      totalQuestion: totalQuestion,
                    )));
      },
    );
  }
}
