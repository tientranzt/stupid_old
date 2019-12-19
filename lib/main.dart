import 'package:flutter/material.dart';
import './pages/login_sceen.dart';
import './pages/create_account_screen.dart';

void main() => runApp(MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (_) => LoginScreen(),
        CreateAccountScreen.id: (_) => CreateAccountScreen()
      },
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
