import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final Color color;
  final icon;

  SocialIcon({this.color,this.icon});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 38,
      icon: Icon(icon),
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 12),
      color: color,
    );
  }
}
