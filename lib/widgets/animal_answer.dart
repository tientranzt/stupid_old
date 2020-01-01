import 'package:flutter/material.dart';

class AnimalAnswer extends StatelessWidget {
  final int title;
  final int indexResult;
  final Function clickAnswerButton;
  Color colorButton;

  AnimalAnswer(
      {this.title, this.indexResult, this.clickAnswerButton, this.colorButton});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: RaisedButton(
          color: colorButton,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            clickAnswerButton(indexResult);
          },
          child: Text(
            '$title',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                color:
                    colorButton == Colors.white ? Colors.black : Colors.white),
          ),
        ));
  }
}
