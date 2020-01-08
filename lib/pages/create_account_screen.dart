import 'package:flutter/material.dart';
import 'package:test_stupid/widgets/submit_button.dart';
import 'package:test_stupid/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String id = 'create_account';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void handleRegistration() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      bool isEmailExist = false;
      bool isEmailValid = RegExp(
              r"^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")
          .hasMatch(_emailController.text);
      int isPassValid = checkPasswordValid(_passwordController.text);
      try {
        await _auth
            .fetchSignInMethodsForEmail(email: _emailController.text)
            .then((value) {
          if (value.length > 0) {
            isEmailExist = true;
          }
        });
      } catch (err) {
        isEmailExist = false;
      }

      if (isEmailValid && isPassValid == 2 && !isEmailExist) {
        _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        _emailController.clear();
        _passwordController.clear();
        _passwordConfirmController.clear();
//        Navigator.pushNamed(context, 'login');
        showDialog(
            context: context,
            builder: (context) {
              var style = TextStyle(
                fontFamily: 'Quicksand',
              );
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: Text(
                    'Thành công !',
                    style: style,
                  ),
                  content: SingleChildScrollView(
                      child: Text(
                    'Đăng ký tài khoản thành công !',
                    style: style,
                  )),
                  actions: <Widget>[
                    FlatButton(
                        child: Text(
                          'Đăng nhập',
                          style: style,
                        ),
                        onPressed: () => Navigator.pushNamed(context, 'login'))
                  ],
                ),
              );
            });
      } else {
        showAlert();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            var style = TextStyle(
              fontFamily: 'Quicksand',
            );
            return AlertDialog(
              title: Text(
                'Thông tin sai !',
                style: style,
              ),
              content: SingleChildScrollView(
                  child: Text(
                'Các ô không được trống',
                style: style,
              )),
              actions: <Widget>[
                FlatButton(
                    child: Text(
                      'Đã hiểu',
                      style: style,
                    ),
                    onPressed: () => Navigator.of(context).pop())
              ],
            );
          });
    }
  }

  showAlert() {
    showDialog(
        context: context,
        builder: (context) {
          var styleText = TextStyle(fontFamily: 'Quicksand');
          return AlertDialog(
            title: Text('Thông tin đăng ký !', style: styleText),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Các ô không được trống.',
                    style: styleText,
                  ),
                  Text(
                    'Email cần chính xác và chưa được đăng ký.',
                    style: styleText,
                  ),
                  Text(
                    'Password tối thiểu 6 ký tự.',
                    style: styleText,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Hiểu ùi, nõi mãi !',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Color(0xFF237658),
                        fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }

  int checkPasswordValid(String pass) {
    if (pass.isEmpty || pass.length < 6) {
      return 0;
    }
    if (_passwordController.text != _passwordConfirmController.text &&
        pass.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return 1;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 30, bottom: 15),
                      child: Text(
                        'Tạo tài khoản',
                        style: TextStyle(
                            color: Color(0xFF2b906b),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand'),
                      ),
                    ),
                    TextFieldCustom(
                      hint: 'Email',
                      iconData: Icons.email,
                      controller: _emailController,
                    ),
                    TextFieldCustom(
                      hint: 'Mật khẩu',
                      iconData: Icons.lock,
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    TextFieldCustom(
                      hint: 'Xác nhận mật khẩu',
                      iconData: Icons.lock,
                      obscureText: true,
                      controller: _passwordConfirmController,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SubmitButton(
                      title: 'Đăng ký',
                      handleSubmit: handleRegistration,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
