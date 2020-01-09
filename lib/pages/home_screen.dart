import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_stupid/pages/game_list_screen.dart';
import 'package:test_stupid/utils/constant.dart';
import 'package:test_stupid/widgets/circle_icon.dart';
import 'package:test_stupid/widgets/dash_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'dart:io';

enum Media { camera, gallery }

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  File _image;
  bool showTest = true;
  double _percent = 0;
  bool _flat = false;

  Future getImage(Media media) async {
    if (media == Media.camera) {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      var pathLocal = await getApplicationDocumentsDirectory();
      await image.copy('${pathLocal.path}/profileImage.jpg');
      setState(() {
        _image = image;
      });
    }
    if (media == Media.gallery) {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      var pathLocal = await getApplicationDocumentsDirectory();
      await image.copy('${pathLocal.path}/profileImage.jpg');
      setState(() {
        _image = image;
      });
    }
  }

  Future _getSaveImage() async {
    var pathLocal = await getApplicationDocumentsDirectory();
    File imageResult;
    try {
      await File(pathLocal.path + '/profileImage.jpg')
          .exists()
          .then((isExists) {
        if (isExists) {
          imageResult = File(pathLocal.path + '/profileImage.jpg');
        } else {
          imageResult = null;
        }
      });
    } on FileSystemException catch (_) {
      imageResult = null;
    }
    setState(() {
      _image = imageResult;
    });
  }

  Future delayPercent() async {
    if (_flat) {
      for (; true;) {
        if (_percent < 1.0) {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            _percent += 0.1;
          });
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getSaveImage();
  }

  @override
  Widget build(BuildContext context) {
//    final List<dynamic> nameUser = ModalRoute.of(context).settings.arguments;
    final List<dynamic> nameUser = ['angela@gmail.com'];
    final String name = nameUser[0].split('@')[0];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
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
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.yellowAccent,
                              ),
                            ),
                            child: PopupMenuButton(
                              onSelected: (Media val) {
                                getImage(val);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              itemBuilder: (context) => <PopupMenuEntry<Media>>[
                                PopupMenuItem<Media>(
                                  value: Media.camera,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.camera_alt),
                                      Text('Chụp ảnh'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<Media>(
                                  value: Media.gallery,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.picture_in_picture),
                                      Text('Chọn ảnh'),
                                    ],
                                  ),
                                )
                              ],
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 45,
                                backgroundImage: _image == null
                                    ? AssetImage('assets/images/account.jpg')
                                    : FileImage(_image),
                              ),
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
                              'Đăng xuất',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  right: 30, left: 30, bottom: 15),
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
                                if (snapshot.hasData) {
                                  String score =
                                      snapshot.data.documents[0]['score'];
                                  return CircleIcon(
                                    icon: Icons.star,
                                    title: 'Độ ngu',
                                    score: score,
                                  );
                                }
                                return CircleIcon(
                                  icon: Icons.star,
                                  title: 'Độ ngu',
                                  score: 'N/A',
                                );
                              }),
                          StreamBuilder<QuerySnapshot>(
                              stream: _firestore
                                  .collection('scores')
                                  .orderBy('score')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
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
                                }
                                return CircleIcon(
                                  icon: Icons.supervisor_account,
                                  title: 'Hạng ngu',
                                  score: 'N/A',
                                );
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                showTest
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: kTextFieldContainer(),
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        'Nhập tên để tính độ ngu theo tên'),
                              ),
                            ),
                            FutureBuilder(
                              future: delayPercent(),
                              builder: (context, snapshot) {
                                return CircularPercentIndicator(
                                  animation: true,
                                  radius: 150.0,
                                  lineWidth: 10.0,
                                  percent: _percent,
                                  center: FlatButton(
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        _flat = true;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(
                                        'ĐO',
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.green,
                                );
                              },
                            )
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(10),
                        child: GameList(
                          loginUser: nameUser[0],
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                      ),
                FlatButton(
                  child: Text('change'),
                  onPressed: () {
                    setState(() {
                      showTest = !showTest;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
