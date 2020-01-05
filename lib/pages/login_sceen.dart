import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_stupid/widgets/submit_button.dart';
import 'package:test_stupid/widgets/text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var keepLogin = false;
  bool showSpinner = false;
  FirebaseUser loginUser;
  TextEditingController _userLoginController = TextEditingController();
  TextEditingController _passLoginController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  handleLoginInformation() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _userLoginController.text,
          password: _passLoginController.text);
      if (user != null) {
        final currentUser = await _auth.currentUser();
        var isUserStoreExist = _firestore
            .collection('scores')
            .where('name', isEqualTo: currentUser.email)
            .getDocuments();
        isUserStoreExist.then((val) => {
              if (val.documents.length == 0)
                {
                  _firestore
                      .collection('scores')
                      .add({'name': currentUser.email, 'score': '0'})
                }
            });
        _userLoginController.clear();
        _passLoginController.clear();

        Navigator.pushNamed(context, 'home',
            arguments: [currentUser.email.toString()]);

        setState(() {
          showSpinner = false;
        });
      }
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Chào!',
                          style: TextStyle(
                              color: Color(0xFF2b906b),
                              fontSize: 60,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Quicksand'),
                        ),
                        padding: EdgeInsets.only(top: 100),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: Text(
                          'Đăng nhập tài khoản',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Quicksand'),
                        ),
                      ),
                    ],
                  ),
                  TextFieldCustom(
                    hint: 'Tài khoản',
                    iconData: Icons.account_circle,
                    controller: _userLoginController,
                  ),
                  TextFieldCustom(
                    hint: 'Mật khẩu',
                    iconData: Icons.lock,
                    controller: _passLoginController,
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Duy trì đăng nhập',
                        style: TextStyle(fontFamily: 'Quicksand'),
                      ),
                      Checkbox(
                          checkColor: Color(0xFF237658),
                          activeColor: Colors.white,
                          value: keepLogin,
                          onChanged: (isCheck) {
                            setState(() {
                              keepLogin = !keepLogin;
                            });
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SubmitButton(
                    title: 'Đăng nhập',
                    handleSubmit: handleLoginInformation,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Chưa có tài khoản? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'create_account');
                            },
                            child: Text(
                              'Tạo tài khoản',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Quicksand'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
