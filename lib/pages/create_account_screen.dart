import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_stupid/widgets/social_icon.dart';
import 'package:test_stupid/widgets/submit_button.dart';
import 'package:test_stupid/widgets/text_field.dart';

class CreateAccountScreen extends StatelessWidget {
  static const String id = 'create_account';

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
        onTap: ()=> FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 15),
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
                        hint: 'Tài khoản',
                        iconData: Icons.account_circle,
                      ),
                      TextFieldCustom(
                        hint: 'Mật khẩu',
                        iconData: Icons.lock,
                        obscureText: true,
                      ),
                      TextFieldCustom(
                        hint: 'Email',
                        iconData: Icons.email,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SubmitButton(
                        title: 'Đăng ký',
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Đăng nhập bằng hình thức khác',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Quicksand'),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SocialIcon(
                        color: Colors.indigo,
                        icon: FontAwesomeIcons.facebook,
                      ),
                      SocialIcon(
                        color: Colors.blue,
                        icon: FontAwesomeIcons.twitter,
                      ),
                      SocialIcon(
                        color: Colors.red,
                        icon: FontAwesomeIcons.google,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
