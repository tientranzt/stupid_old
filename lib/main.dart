import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_stupid/models/animal_game_model.dart';
import 'package:test_stupid/pages/count_sheep_game.dart';
import 'package:test_stupid/pages/finger_power_game.dart';
import 'package:test_stupid/pages/home_screen.dart';
import 'package:test_stupid/pages/math_animal_game.dart';
import 'package:test_stupid/pages/play_animal_game.dart';
import 'package:test_stupid/pages/stupid_question_game.dart';
import './pages/login_sceen.dart';
import './pages/create_account_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider<AnimalGameProvider>(create: (_) => AnimalGameProvider()),
        ],
        child:
        MaterialApp(
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id: (_) => LoginScreen(),
            CreateAccountScreen.id: (_) => CreateAccountScreen(),
            HomeScreen.id: (_) => HomeScreen(),
            AnimalMathGame.id: (_) => AnimalMathGame(),
            PlayAnimalGame.id: (_)=> PlayAnimalGame(),
            CountSheepGame.id: (_) => CountSheepGame(),
            PowerFingerGame.id: (_) => PowerFingerGame(),
            StupidQuestionGame.id: (_) => StupidQuestionGame(),

          },
          debugShowCheckedModeBanner: false,
          home: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
