import 'package:flutter/material.dart';
import 'package:test_stupid/pages/game_list_screen.dart';
import 'package:test_stupid/widgets/circle_icon.dart';
import 'package:test_stupid/widgets/dash_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> nameUser = ModalRoute.of(context).settings.arguments;
    final String name = nameUser[0].split('@')[0];
    final sizeScreen = (MediaQuery.of(context).size.height) / 2;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFF237658),
        body: ListView(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton.icon(
                          onPressed: () {
                            _auth.signOut();
                            Navigator.pushNamed(context, 'login');
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Thoát',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),

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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
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
                        StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection('scores')
                                .where('name', isEqualTo: nameUser[0])
                                .snapshots(),
                            builder: (context, snapshot) {
                              String score =
                                  snapshot.data.documents[0]['score'];
                              return CircleIcon(
                                icon: Icons.star,
                                title: 'Độ ngu',
                                score: score,
                              );
                            }),
                        StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection('scores')
                                .orderBy('score')
                                .snapshots(),
                            builder: (context, snapshot) {
                              int rank = 0;
                              var users = snapshot.data.documents;
                              for (var i = 0; i < users.length; i++) {

                                if (users[i]['name'] == nameUser[0]) {
                                  rank = i + 1;
                                  break;
                                }
                              }
                              return CircleIcon(
                                icon: Icons.supervisor_account,
                                title: 'Hạng ngu',
                                score: rank.toString(),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GameList(loginUser: nameUser[0],),
              height: sizeScreen,
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
            )
          ],
        ),
      ),
    );
  }
}
