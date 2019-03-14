import 'package:data/models/contest_session.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/game_utils.dart';
import 'package:jamaica/widgets/slide_up_route.dart';

class Game extends StatefulWidget {
  final ContestSession contestSession;

  const Game({Key key, this.contestSession}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _currentGame = 0;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => SlideUpRoute(widgetBuilder: _buildGame),
    );
  }

  Widget _buildGame(BuildContext context) {
    if (_currentGame < widget.contestSession.gameData.length) {
      return buildGame(
          gameData: widget.contestSession.gameData[_currentGame],
          onGameOver: (score) {
            _currentGame++;
            Navigator.pushReplacement(
                context, SlideUpRoute(widgetBuilder: _buildGame));
          });
    } else {
      return Container();
    }
  }
}
