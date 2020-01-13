import 'package:flutter/material.dart';

class NameUserTestStupid extends StatelessWidget {

  final String nameUserTesting;
  final String scoreUserTesting;

  NameUserTestStupid({this.nameUserTesting, this.scoreUserTesting});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            nameUserTesting,
            style: TextStyle(
                color: Color(0xFF237658)),
          ),
          Text(
            '$scoreUserTesting',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 50,
                color: Colors.redAccent),
          ),
          Text(
            'ĐỘ NGU',
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.redAccent),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
