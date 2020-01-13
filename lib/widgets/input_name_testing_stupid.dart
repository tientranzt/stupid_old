import 'package:flutter/material.dart';


class InputNameTestingStupid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Center(
          child: Text(
            'NHẬP TÊN VÀ NHẤN TEST',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF237658)),
            textAlign: TextAlign.center,
          )),
    );
  }
}
