import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_stupid/widgets/submit_button.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(
              builder: (context, viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
//                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Chào!',
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'OpenSans'),
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
                                      fontFamily: 'OpenSans'),
                                ),
                              ),
                            ],
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
                          SizedBox(
                            height: 50,
                          ),
                          SubmitButton(title: 'Đăng nhập'),
                          Expanded(
                            child: Column(
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
                                        Navigator.pushNamed(
                                            context, 'create_account');
                                      },
                                      child: Text(
                                        'Tạo tài khoản',
                                        style: TextStyle(
                                            decoration: TextDecoration
                                                .underline,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'OpenSans'),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
