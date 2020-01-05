import 'package:flutter/material.dart';
import 'package:test_stupid/pages/game_list_screen.dart';
import 'package:test_stupid/widgets/circle_icon.dart';
import 'package:test_stupid/widgets/dash_separator.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    final nameUser = ModalRoute.of(context).settings.arguments.toString();
    final String name = nameUser.substring(1, nameUser.indexOf('@'));
    final sizeScreen = (MediaQuery.of(context).size.height) / 2;
    return Scaffold(
      backgroundColor: Color(0xFF237658),
      body: ListView(
        children: <Widget>[
          Container(
            height: sizeScreen,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4eca9d),
                    Color(0xFF35b183),
                    Color(0xFF2b906b),
                    Color(0xFF237658),
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.yellowAccent,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        backgroundImage:
                            AssetImage('assets/images/demo_account.jpg'),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      name,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: DashSeparator())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleIcon(
                      icon: Icons.timeline,
                      title: 'Danh hiệu',
                      score: '5',
                    ),
                    CircleIcon(
                      icon: Icons.star,
                      title: 'Điểm',
                      score: '120',
                    ),
                    CircleIcon(
                      icon: Icons.supervisor_account,
                      title: 'Hạng',
                      score: '5tr',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding:EdgeInsets.all(10),
            child: GameList(),
            height: sizeScreen,
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
          )
        ],
      ),
    );
  }
}
