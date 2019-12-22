import 'package:flutter/material.dart';
import 'package:test_stupid/pages/home_screen.dart';

class SubmitButton extends StatelessWidget {
  final String title;

  SubmitButton({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Quicksand'),
        ),
        Container(
          width: 60,
          margin: EdgeInsets.only(left: 8, bottom: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(24), right: Radius.circular(24)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF9de2c8),
                    Color(0xFF4eca9d),
                    Color(0xFF35b183),
                    Color(0xFF2b906b),
                  ])),
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              size: 26,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(HomeScreen.id);
            },
            color: Colors.white,

          ),
        )
      ],
    );
  }
}
