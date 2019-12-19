import 'package:flutter/material.dart';

BoxDecoration kTextFieldContainer() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(50),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    // color: Colors.grey,
  );
}

InputDecoration kTextFieldStyle(
    {@required String hint, @required IconData preIcon}) {
  return InputDecoration(
    border: InputBorder.none,
    hintStyle: TextStyle(fontSize: 17,fontFamily: 'Quicksand'),
    prefixIcon: Icon(
      preIcon,
      color: Colors.black,
      size: 22,
    ),
    hintText: hint,


  );
}
