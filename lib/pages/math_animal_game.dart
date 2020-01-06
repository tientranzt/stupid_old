import 'package:flutter/material.dart';
import 'package:test_stupid/models/animal_game_model.dart';
import 'package:test_stupid/widgets/example_animal_game.dart';
import 'package:test_stupid/widgets/how_to_play_animal_game.dart';
import 'package:test_stupid/widgets/level_difficult_game.dart';
import 'package:provider/provider.dart';

class AnimalMathGame extends StatelessWidget {
  static final String id = 'animal_math_game';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 90),
                child: Text(
                  'Thần Thú Toán',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Color(0xFF237658),
                      fontSize: 26,
                      decorationStyle: TextDecorationStyle.wavy,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LevelDifficultGame(
                    title: 'Dễ',
                    color: Color(0xFF4eca9d),
                    levelDifficult: 20,
                  ),
                  LevelDifficultGame(
                    title: 'Vừa',
                    color: Color(0xFF2b906b),
                    levelDifficult: 15,
                  ),
                  LevelDifficultGame(
                    title: 'Khó',
                    color: Color(0xFF1d6249),
                    levelDifficult: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'home', arguments: []);
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.redAccent,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.help,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Hướng dẫn',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '- Chọn 1 trong 4 đáp án trong game.\n'
                                      '- Đáp án là tổng các điểm của thần thú.\n'
                                      'Ví dụ:\n',
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          color: Color(0xFF237658),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            ExampleAnimalGame(
                                              name: 'ti',
                                              score: 1,
                                            ),
                                            Text(' + '),
                                            ExampleAnimalGame(
                                              name: 'mao',
                                              score: 4,
                                            )
                                          ],
                                        ),
                                        Text(
                                          ' = 5',
                                          style: TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    ...Provider.of<AnimalGameProvider>(context)
                                        .listZodiac
                                        .keys
                                        .map((zodiac) {
                                      return HowToPlayAnimalGame(
                                        path: zodiac,
                                        name: Provider.of<AnimalGameProvider>(
                                                context)
                                            .listZodiac[zodiac]['name'],
                                        score: Provider.of<AnimalGameProvider>(
                                                context)
                                            .listZodiac[zodiac]['score'],
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Tớ đã hiểu',
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          color: Color(0xFF237658),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ],
                            );
                          });
                    },
                  )
                ],
              ),
            ])),
      ),
    );
  }
}
