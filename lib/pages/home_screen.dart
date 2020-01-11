import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_stupid/pages/game_list_screen.dart';
import 'package:test_stupid/utils/constant.dart';
import 'package:test_stupid/widgets/circle_icon.dart';
import 'package:test_stupid/widgets/circle_progress.dart';
import 'package:test_stupid/widgets/dash_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

enum Media { camera, gallery }

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  TextEditingController nameUserController = TextEditingController();
  File _image;
  bool showTest;
  int scoreStupid = 0;

  bool _showHome = false;

  AnimationController _progressController;
  Animation<double> animation;

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

  Future getTestKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var flatRun = prefs.getBool('showtest') ?? true;
    setState(() {
      showTest = flatRun;
    });
  }

  Future setTestKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showtest', false);
  }

  void setScoreStupid() {
    var string = nameUserController.text;
    var sum = 0;
    for (var i = 0; i < string.length; i++) {
      sum += string[i].codeUnitAt(0);
    }
    Random random = Random();

    sum += random.nextInt(2000);

    if (sum < 100) {
      sum += 2614;
    }
    if (sum < 200) {
      sum += 2428;
    }
    if (sum < 300) {
      sum += 1930;
    }
    if (sum < 400) {
      sum += 1849;
    }
    if (sum < 500) {
      sum += 1763;
    }
    if (sum < 600) {
      sum += 1659;
    }
    if (sum < 700) {
      sum += 1502;
    }
    if (sum < 800) {
      sum += 1469;
    }
    if (sum < 900) {
      sum += 1357;
    }
    if (sum < 1000) {
      sum += 1211;
    }
    if (sum > 3000) {
      sum = 2203 + Random().nextInt(500);
    }

    List<dynamic> user = ModalRoute.of(context).settings.arguments;
    _firestore.collection('scores').document(user[0]).updateData({"score": sum.toString()});
    setState(() {
      scoreStupid = sum;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSaveImage();
    getTestKey();
    _progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    animation = Tween<double>(begin: 0, end: 100).animate(_progressController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> nameUser = ModalRoute.of(context).settings.arguments;
//    final List<dynamic> nameUser = ['angela@gmail.com'];
    final String name = nameUser[0].split('@')[0];
    var styleCircle = TextStyle(
        color: Colors.white,
        fontFamily: 'Quicksand',
        fontSize: 40,
        fontWeight: FontWeight.bold);
    return FutureBuilder(
        future: getTestKey(),
        builder: (context, _) {
          return WillPopScope(
            onWillPop: () async => false,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: Color(0xFFFFFFFF),
                body: SafeArea(
                  child: showTest == null
                      ? Container()
                      : showTest
                          ? ListView(
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                ),
                                animation.value == 100.0
                                    ? Center(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              nameUserController.text,
                                              style: TextStyle(
                                                  color: Color(0xFF237658)),
                                            ),
                                            Text(
                                              '$scoreStupid',
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 50,
                                                  color: Colors.redAccent),
                                            ),
                                            Text(
                                              'ĐỘ NGU',
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
//                                                fontSize: 50,
                                                  color: Colors.redAccent),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
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
                                      ),
                                animation.value == 100
                                    ? Container()
                                    : CustomPaint(
                                        foregroundPainter: CircleProgress(
                                            currentProgress: animation.value),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              if (nameUserController
                                                      .text.length >
                                                  0) {
                                                setState(() {
                                                  _showHome = true;
                                                });
                                                setScoreStupid();
                                                if (animation.value == 100.0) {
                                                  _progressController.stop();
                                                } else {
                                                  _progressController.forward();
                                                }
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Center(
                                                              child: Text(
                                                                  'Nhập tên mới test đc á !')),
                                                        ),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text(
                                                              'Để tui nhập',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF237658)),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              }
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                              decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  shape: BoxShape.circle),
                                              child: animation.value == 0
                                                      ? Text('TEST',
                                                          style: styleCircle)
                                                      : Text(
                                                          animation.value
                                                                  .toInt()
                                                                  .toString() +
                                                              '%',
                                                          style: styleCircle,
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ),
                                _showHome
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 50),
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
                                            color: Color(0xFF237658),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                setTestKey();
                                                showTest = false;
                                              });
                                            },
                                            child: Text(
                                              'Về trang chủ',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      )
                                    : Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        decoration: kTextFieldContainer(),
                                        child: TextField(
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          controller: nameUserController,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF237658),
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Mời nhập tên',
                                            hintStyle: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Quicksand'),
                                          ),
                                        ),
                                      ),
                              ],
                            )
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
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
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                  color: Colors.yellowAccent,
                                                ),
                                              ),
                                              child: PopupMenuButton(
                                                onSelected: (Media val) {
                                                  getImage(val);
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                itemBuilder: (context) =>
                                                    <PopupMenuEntry<Media>>[
                                                  PopupMenuItem<Media>(
                                                    value: Media.camera,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Icon(Icons
                                                            .picture_in_picture),
                                                        Text('Chọn ảnh'),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 45,
                                                  backgroundImage: _image ==
                                                          null
                                                      ? AssetImage(
                                                          'assets/images/account.jpg')
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
                                                Navigator.pushNamed(
                                                    context, 'login');
                                              },
                                              icon: Icon(
                                                Icons.exit_to_app,
                                                color: Colors.white,
                                              ),
                                              label: Text(
                                                'Đăng xuất',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    right: 30,
                                                    left: 30,
                                                    bottom: 15),
                                                child: DashSeparator())
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            CircleIcon(
                                              icon: Icons.timeline,
                                              title: 'Danh hiệu',
                                              score: '5',
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                                stream: _firestore
                                                    .collection('scores')
                                                    .where('name',
                                                        isEqualTo: nameUser[0])
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    String score = snapshot.data
                                                        .documents[0]['score'];
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
                                                    var users =
                                                        snapshot.data.documents;
                                                    for (var i = 0;
                                                        i < users.length;
                                                        i++) {
                                                      if (users[i]['name'] ==
                                                          nameUser[0]) {
                                                        rank = i + 1;
                                                        break;
                                                      }
                                                    }
                                                    return CircleIcon(
                                                      icon: Icons
                                                          .supervisor_account,
                                                      title: 'Hạng ngu',
                                                      score: rank.toString(),
                                                    );
                                                  }
                                                  return CircleIcon(
                                                    icon: Icons
                                                        .supervisor_account,
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
                                  Container(
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
                                ],
                              ),
                            ),
                ),
              ),
            ),
          );
        });
  }
}
