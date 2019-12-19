import 'package:flutter/material.dart';

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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'OpenSans'),
        ),
        Container(
          width: 60,
          margin: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(24), right: Radius.circular(24)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFb3e6b3),
                    Color(0xFF66cc66),
                    Color(0xFF39ac39),
                    Color(0xFF2d862d),
                  ])),
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              size: 26,
            ),
            onPressed: () {
              print(this.title);
            },
            color: Colors.white,

          ),
        )
      ],
    );
  }
}
