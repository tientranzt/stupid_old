import 'package:flutter/material.dart';
import '../utils/constant.dart';

class TextFieldCustom extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final bool obscureText;

  TextFieldCustom(
      {@required this.hint,
      @required this.iconData,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: kTextFieldContainer(),
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
        decoration: kTextFieldStyle(hint: hint, preIcon: iconData),
      ),
    );
  }
}
