import 'package:flutter/material.dart';

class ListGame extends StatelessWidget {
  final String title;
  final icon;
  final color;
  final String routeGame;
  final loginUser;

  ListGame({this.title, this.icon, this.color, this.routeGame, this.loginUser});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: CircleAvatar(
       maxRadius: 20,
        backgroundColor: color,
        child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: null),
      ),
      title: Text(
        title,
        style: TextStyle(fontFamily: 'Quicksand'),
        maxLines: 1,
      ),
      trailing: RaisedButton(
        elevation: 6,
        child: Text(
          'Chơi',
          style: TextStyle(color: Colors.black),
        ),
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, routeGame, arguments: [loginUser]);
        },
      ),
    );
  }
}
