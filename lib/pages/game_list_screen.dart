import 'package:flutter/material.dart';
import 'package:test_stupid/widgets/list_game.dart';

class GameList extends StatelessWidget {
  final String loginUser;
  GameList({this.loginUser});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListGame(
          color: Color(0xFF237658),
          icon: Icons.email,
          title: 'Làm toán siêu thú',
          routeGame: 'animal_math_game',
          loginUser: loginUser,
        ),
        ListGame(
          color: Color(0xFFcccc00),
          icon: Icons.data_usage,
          title: 'Đếm cừu ít khi đúng',
          routeGame: 'count_sheep_game',
        ),
        ListGame(
          color: Color(0xFF237658),
          icon: Icons.score,
          title: 'Ngón tay quyền năng',
          routeGame: 'power_finger_game',
        ),
        ListGame(
          color: Color(0xFFcccc00),
          icon: Icons.supervisor_account,
          title: 'Trả lời câu hỏi ngu',
          routeGame: 'stupid_question_game',
        ),
      ],
    );
  }
}
