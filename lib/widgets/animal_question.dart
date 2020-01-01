import 'package:flutter/material.dart';

class AnimalQuestion extends StatelessWidget {
  final String nameAnimal;
  AnimalQuestion({this.nameAnimal});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      height: 85,
      width: 85,
      child: Image.asset(
        'assets/images/zodiac/$nameAnimal.png',
      ),
    );
  }
}
