import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_stupid/models/animal_game_model.dart';
import 'dart:async';
import 'dart:math';
import 'package:test_stupid/widgets/animal_answer.dart';
import 'package:test_stupid/widgets/animal_question.dart';

class PlayAnimalGame extends StatefulWidget {
  static const String id = 'play_animal_game';

  final int levelDifficultTimer;

  PlayAnimalGame({this.levelDifficultTimer});

  @override
  _PlayAnimalGameState createState() => _PlayAnimalGameState();
}

class _PlayAnimalGameState extends State<PlayAnimalGame> {
  Timer _timer;
  int _startTimer;
  int _countQuestion = 1;
  List _randomZodiac = [];
  List _resultList = [];
  int _exactlyResult = 0;
  bool isTrue = false;
  bool flatAlertMessage = true;

  Color colorButton = Colors.white;
  List<Color> listColorAnswer = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  Map<String, Map<String, dynamic>> _listZodiac = {};

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _startTimer == 0 ? timer.cancel() : _startTimer = _startTimer - 1;
          if (_startTimer == 0 && flatAlertMessage == true) {
            _neverSatisfied();
            flatAlertMessage = false;
          }
        },
      ),
    );
  }

  void get4Answer() {
    var rnd = Random();
    var tempList = List.generate(3, (_) {
      var num = rnd.nextInt(11) * 4 + 4;
      if (_resultList.contains(num)) {
        return num + 8;
      }
      return num;
    });
    setState(() {
      _resultList = tempList;
      _resultList.insert(rnd.nextInt(4), _exactlyResult);
    });
  }

  void get4RandomZodiac() {
    var random = Random();
    var listRandom = List.generate(4, (_) => random.nextInt(11));
    setState(() {
      _randomZodiac = listRandom;
    });
  }

  void sumResult() {
    var one = _listZodiac[_listZodiac.keys.toList()[_randomZodiac[0]]]['score'];
    var two = _listZodiac[_listZodiac.keys.toList()[_randomZodiac[1]]]['score'];
    var three =
        _listZodiac[_listZodiac.keys.toList()[_randomZodiac[2]]]['score'];
    var four =
        _listZodiac[_listZodiac.keys.toList()[_randomZodiac[3]]]['score'];

    setState(() {
      _exactlyResult = (one + two + three + four);
      startTimer();
    });
    print(_exactlyResult);
  }

  void clickAnswerButton(int indexResultList) {
    setState(() {
      listColorAnswer = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white
      ];
      listColorAnswer[indexResultList] = Colors.redAccent;

      isTrue = _resultList[indexResultList] == _exactlyResult;
    });
  }

  void nextGame() {
    setState(() {
      listColorAnswer = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white
      ];
      isTrue = false;
      flatAlertMessage = true;
      _countQuestion++;
      _startTimer = widget.levelDifficultTimer;

      get4RandomZodiac();
      sumResult();
      get4Answer();

    });
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child:  _countQuestion == 10 ? AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Câu $_countQuestion'),
                  isTrue
                      ? Text('Thật trúy tệ',
                      style: TextStyle(fontFamily: 'Quicksand'))
                      : Text(
                    'Ngu người',
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                  isTrue ? Text('+20 điểm') : Text('+0 điểm'),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Color(0xFF237658),
                    child: Text(
                      'Về trang chủ',
                      style:
                      TextStyle(color: Colors.white, fontFamily: 'Quicksand'),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('animal_math_game');
                    },
                  ),
                ],
              ),
            ),
          ): AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Câu $_countQuestion'),
                  isTrue
                      ? Text('Thật trúy tệ',
                      style: TextStyle(fontFamily: 'Quicksand'))
                      : Text(
                    'Ngu người',
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                  isTrue ? Text('+20 điểm') : Text('+0 điểm'),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Color(0xFF237658),
                    child: Text(
                      'Tiếp',
                      style:
                      TextStyle(color: Colors.white, fontFamily: 'Quicksand'),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      nextGame();
                    },
                  ),
                ],
              ),
            ),
          ) ,
        ) ;

      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listZodiac = Provider.of<AnimalGameProvider>(context).listZodiac;
    sumResult();
    get4Answer();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _startTimer = widget.levelDifficultTimer ?? 0;
      get4RandomZodiac();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, viewConstraints) {
        return SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewConstraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        Color(0xFF4eca9d),
                        Color(0xFF35b183),
                        Color(0xFF2b906b),
                        Color(0xFF237658),
                      ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Text('$_countQuestion/10', style: TextStyle(fontFamily: 'Quicksand'),),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            height: 35,
                            width: 72,
                            child: Center(
                                child: Text(
                              '$_startTimer' + 's',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Quicksand'),
                            )),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 25),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  AnimalQuestion(
                                    nameAnimal: _listZodiac.keys
                                        .toList()[_randomZodiac[0]],
                                  ),
                                  AnimalQuestion(
                                    nameAnimal: _listZodiac.keys
                                        .toList()[_randomZodiac[1]],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  AnimalQuestion(
                                    nameAnimal: _listZodiac.keys
                                        .toList()[_randomZodiac[2]],
                                  ),
                                  AnimalQuestion(
                                    nameAnimal: _listZodiac.keys
                                        .toList()[_randomZodiac[3]],
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AnimalAnswer(
                                title: _resultList[0],
                                indexResult: 0,
                                clickAnswerButton: clickAnswerButton,
                                colorButton: listColorAnswer[0],
                              ),
                              AnimalAnswer(
                                title: _resultList[1],
                                indexResult: 1,
                                clickAnswerButton: clickAnswerButton,
                                colorButton: listColorAnswer[1],
                              ),
                              AnimalAnswer(
                                title: _resultList[2],
                                indexResult: 2,
                                clickAnswerButton: clickAnswerButton,
                                colorButton: listColorAnswer[2],
                              ),
                              AnimalAnswer(
                                title: _resultList[3],
                                indexResult: 3,
                                clickAnswerButton: clickAnswerButton,
                                colorButton: listColorAnswer[3],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
